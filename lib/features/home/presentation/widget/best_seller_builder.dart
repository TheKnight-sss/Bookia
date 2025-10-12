import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/widget/book_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BestSellerBuilder extends StatefulWidget {
  const BestSellerBuilder({super.key, required this.books});

  final List<Product> books;

  @override
  State<BestSellerBuilder> createState() => _BestSellerBuilderState();
}

class _BestSellerBuilderState extends State<BestSellerBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(20),
        Text("Best Seller", style: TextStyles.styleSize24()),
        Gap(15),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 285,
          ),
          itemCount: widget.books.length,
          itemBuilder: (context, index) {
            return BookCard(book: widget.books[index]);
          },
        ),
      ],
    );
  }
}
