import 'package:bookia/Components/app_bar_with_back.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.book});

  final Product book;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          showLoadingDialog(context);
        } else if (state is HomeSuccessState) {
          pop(context);
          showMyDialog(context, state.message ?? '', type: Dialogs.success);
        } else if (state is HomeErrorState) {
          pop(context);
          showMyDialog(context, 'Something went wrong', type: Dialogs.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBarWithBack(
            action: [
              IconButton(
                onPressed: () {
                  cubit.addRemoveToWishList(productId: book.id ?? 0);
                },
                icon: cubit.checkIfInWishList(book.id ?? 0)
                    ? SvgPicture.asset(
                        AppImages.bookmark,
                        colorFilter: ColorFilter.mode(
                          AppColor.primaryColor,
                          BlendMode.srcIn,
                        ),
                      )
                    : SvgPicture.asset(AppImages.bookmark),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    children: [
                      Hero(
                        tag: book.id ?? '',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: book.image ?? '',
                            width: 185,
                            height: 270,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, StackTrace) {
                              return Image.asset(
                                AppImages.welcome,
                                width: 185,
                                height: 270,
                              );
                            },
                          ),
                        ),
                      ),
                      Gap(25),
                      Text(book.name ?? "", style: TextStyles.styleSize24()),
                      Gap(10),
                      Text(
                        book.category ?? "",
                        style: TextStyles.styleSize16(
                          color: AppColor.primaryColor,
                        ),
                      ),
                      Gap(20),
                      Text(
                        book.description ?? "",
                        style: TextStyles.styleSize14(),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$${book.priceAfterDiscount}",
                    style: TextStyles.styleSize24(),
                  ),
                  Gap(40),
                  Expanded(
                    child: MainButton(
                      text: "Add To Cart",
                      onPressed: () {
                        cubit.addToCart(productId: book.id ?? 0);
                      },
                      bgColor: AppColor.darkColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
