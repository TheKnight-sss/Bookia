import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/core/Utils/colors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(title: Text("Cart")),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            var cubit = context.read<CartCubit>();
            var books = cubit.cartResponse?.data?.cartItems ?? [];
            if (state is! CartStateSuccessState) {
              return Center(child: CircularProgressIndicator());
            }
            //after success state
            if (books.isEmpty) {
              return _emptyUI();
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(20),
                    itemCount: books.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return CartCard(
                        book: books[index],
                        onDelete: () {
                          cubit.removeFromCart(
                            cartItemId: books[index].itemId ?? 0,
                          );
                        },
                        onUpdate: (q) {
                          cubit.updateCart(
                            cartItemId: books[index].itemId ?? 0,
                            quantity: q,
                          );
                        },
                        onRefesh: () {
                          cubit.getCart();
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Price", style: TextStyles.styleSize18()),
                          Text(
                            "${cubit.cartResponse?.data?.total ?? 0}\$",
                            style: TextStyles.styleSize18(
                              fontweight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      MainButton(
                        text: 'CheckOut',
                        onPressed: () {
                          pushTo(
                            context,
                            Routes.placeOrder,
                            extra: "${cubit.cartResponse?.data?.total ?? 0}",
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Center _emptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.bookmark,
            height: 100,
            colorFilter: ColorFilter.mode(
              AppColor.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          Gap(20),
          Text("Your Cart is empty", style: TextStyles.styleSize18()),
        ],
      ),
    );
  }
}

// class CartCard extends StatelessWidget {
//   const CartCard({super.key, required this.book, required this.onDelete});

//   final WishListProduct book;
//   final Function() onDelete;
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//       key: UniqueKey(),
//       direction: DismissDirection.endToStart,
//       background: Container(
//         decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         alignment: Alignment.centerRight,
//         padding: EdgeInsets.only(right: 20),
//         child: Icon(Icons.delete, color: Colors.white),
//       ),
//       onDismissed: (direction) {
//         onDelete();
//       },
//       child: Container(
//         height: 140,
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(30),
//               child: CachedNetworkImage(
//                 imageUrl: book.image ?? '',
//                 width: 100,
//                 height: 120,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => CircularProgressIndicator(),
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//               ),
//             ),
//             Gap(15),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Text(
//                     book.name ?? '',
//                     style: TextStyles.styleSize18(),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Gap(6),
//                   Text("\$${book.price}", style: TextStyles.styleSize16()),
//                   Gap(8),
//                   Text(
//                     book.description ?? '',
//                     style: TextStyles.styleSize14(color: AppColor.greyColor),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
