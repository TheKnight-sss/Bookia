import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/functions/dialogs.dart';
import 'package:bookia/features/cart/data/model/cart_response/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.book,
    required this.onDelete,
    required this.onRefesh,
    required this.onUpdate,
  });

  final CartItem book;
  final Function() onDelete;
  final Function() onRefesh;
  final Function(int) onUpdate;

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
        // onTap: () {
        //   pushTo(
        //     context,
        //     Routes.details,
        //     extra: book.maptoProduct(),
        //   ).then((value) {});
        // },
        child: Container(
          height: 140,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Hero(
                tag: book.itemProductId ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: book.itemProductImage ?? '',
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
                      book.itemProductName ?? '',
                      style: TextStyles.styleSize18(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(6),
                    Text(
                      "\$${book.itemProductPrice}",
                      style: TextStyles.styleSize16(),
                    ),
                    Gap(20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((book.itemQuantity ?? 1) > 1) {
                              int newQuantity = (book.itemQuantity ?? 1) - 1;
                              onUpdate(newQuantity);
                            } else {
                              showMyDialog(context, "Minimum quantity reached");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        Gap(10),
                        Text(
                          "${book.itemQuantity}",
                          style: TextStyles.styleSize16(),
                        ),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            if ((book.itemQuantity ?? 1) <
                                (book.itemProductStock ?? 1)) {
                              int newQuantity = (book.itemQuantity ?? 1) + 1;
                              onUpdate(newQuantity);
                            } else {
                              showMyDialog(context, "Out of stock");
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
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
