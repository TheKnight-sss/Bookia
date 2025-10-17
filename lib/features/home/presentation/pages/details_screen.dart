import 'package:bookia/Components/app_bar_with_back.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.book});

  final Product book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        action: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppImages.bookmark),
          ),
        ],
      ),
      body: Padding(
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
                  style: TextStyles.styleSize16(color: AppColor.primaryColor),
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
                  onPressed: () {},
                  bgColor: AppColor.darkColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
