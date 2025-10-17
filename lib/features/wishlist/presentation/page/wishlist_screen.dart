import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/features/wishlist/data/model/wish_list_response/datum.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:bookia/features/wishlist/widgets/wish_list_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishList(),
      child: Scaffold(
        appBar: AppBar(title: Text("wishlist")),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) { 
            var cubit = context.read<WishlistCubit>();
            if (state is! WishlistSuccessState) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.separated(
            padding: EdgeInsets.all(20),
            itemCount: cubit.books.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return WishListCard(book: cubit.books[index],);
            },
          );
          }
        ),
      ),
    );
  }
}



class WishListCard extends StatelessWidget {
  const WishListCard({super.key,required this.book});

  final WishListProduct book;
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
              child: CachedNetworkImage(imageUrl: book.image?? '', width: 100,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    book.name ??'',
                    style: TextStyles.styleSize18(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(6),
                  Text("\$${book.price}", style: TextStyles.styleSize16()),
                  Gap(8),
                  Text(
                    book.description ??'',
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
