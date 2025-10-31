import 'dart:math';

import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/features/cart/data/model/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/model/place_order_params.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartStateInitialState());

  final formkey = GlobalKey<FormState>();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final governorateController = TextEditingController();

  int selectedGovId = -1;

  // List<CartProduct> books = [];
  CartResponse? cartResponse;

  getCart() async {
    emit(CartStateLoadingState());

    var res = await CartRepo().getCart();

    if (res != null) {
      cartResponse = res;
      emit(CartStateSuccessState());
    } else {
      emit(CartStateFailureState());
    }
  }

  removeFromCart({required int cartItemId}) async {
    emit(CartStateLoadingState());

    var res = await CartRepo.removeFromCart(cartItemId: cartItemId);

    if (res != null) {
      cartResponse = res;
      emit(CartStateSuccessState());
    } else {
      emit(CartStateFailureState());
    }
  }

  updateCart({required int cartItemId, required int quantity}) async {
    var res = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );

    if (res != null) {
      cartResponse = res;
      emit(CartStateSuccessState());
    } else {
      emit(CartStateFailureState());
    }
  }

  placeOrder() async {
    emit(CartStateLoadingState());

    var params = PlaceOrderParams(
      name: fullnameController.text,
      email: emailController.text,
      address: addressController.text,
      phone: phoneController.text,
      governorateId: selectedGovId,
    );

    var res = await CartRepo.placeOrder(params);

    if (res) {
      emit(CartStateSuccessState());
    } else {
      emit(CartStateFailureState());
    }
  }

  prefillOrderDate() {
    var user = SharedPref.getUserData();
    fullnameController.text = user?.user?.name ?? '';
    emailController.text = user?.user?.email ?? '';
    addressController.text = user?.user?.address ?? '';
    phoneController.text = user?.user?.phone ?? '';
  }
}
