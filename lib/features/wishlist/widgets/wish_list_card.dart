import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishListCard extends StatelessWidget {
  const WishListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        height: 140,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                AppImages.welcome,
                width: 100,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Book Title",
                    style: TextStyles.styleSize18(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(6),
                  Text("Author Name", style: TextStyles.styleSize16()),
                  Gap(8),
                  Text(
                    "Price",
                    style: TextStyles.styleSize14(color: AppColor.greyColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
