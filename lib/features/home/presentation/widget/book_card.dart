import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final Product book;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          pushTo(context, Routes.details, extra: book);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColor.accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: book.id ?? "",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: book.image ?? '',
                      width: double.infinity,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, StackTrace) {
                        return Image.asset(
                          AppImages.welcome,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              Gap(10),
              SizedBox(
                height: 45,
                child: Text(
                  book.name ?? '',
                  style: TextStyles.styleSize16(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "\$${book.priceAfterDiscount}",
                      style: TextStyles.styleSize16(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  MainButton(
                    text: "Buy",
                    onPressed: () {},
                    width: 82,
                    height: 30,
                    bgColor: AppColor.darkColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
