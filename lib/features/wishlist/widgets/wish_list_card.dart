import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/wishlist/data/model/wish_list_response/datum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishListCard extends StatelessWidget {
  const WishListCard({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onRefesh,
  });

  final WishListProduct book;
  final Function onDelete;
  final Function onRefesh;

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
      onDismissed: (direction) {
        onDelete();
      },
      child: GestureDetector(
        onTap: () {
          pushTo(
            context,
            Routes.details,
            extra: book.maptoProduct(),
          ).then((value) {});
        },
        child: Container(
          height: 140,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Hero(
                tag: book.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: book.image ?? '',
                    width: 100,
                    height: 120,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      book.name ?? '',
                      style: TextStyles.styleSize18(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(6),
                    Text("\$${book.price}", style: TextStyles.styleSize16()),
                    Gap(8),
                    Text(
                      book.description ?? '',
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
      ),
    );
  }
}
