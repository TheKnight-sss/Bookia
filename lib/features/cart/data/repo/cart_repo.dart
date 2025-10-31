import 'dart:developer';

import 'package:bookia/core/Services/dio/api_endpoint.dart';
import 'package:bookia/core/Services/dio/dio_provider.dart';
import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/features/cart/data/model/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/model/place_order_params.dart';

class CartRepo {
  Future<CartResponse?> getCart() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndPoint.cart,
        headers: {'Authorization': "Bearer ${SharedPref.getUserData()?.token}"},
      );
      if (res.statusCode == 200) {
        var data = CartResponse.fromJson(res.data);

        return data;
      } else {
        throw Exception("Failed to load Cart");
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> addToCart({required int productId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndPoint.addToCart,
        headers: {'Authorization': "Bearer ${SharedPref.getUserData()?.token}"},
        data: {"product_id": productId},
      );
      if (res.statusCode == 201) {
        var data = CartResponse.fromJson(res.data);
        return data;
      } else {
        throw Exception("Failed to load Cart");
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> removeFromCart({required int cartItemId}) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndPoint.removeFromCart,
        headers: {'Authorization': "Bearer ${SharedPref.getUserData()?.token}"},
        data: {"cart_item_id": cartItemId},
      );
      if (res.statusCode == 200) {
        var data = CartResponse.fromJson(res.data);
        return data;
      } else {
        throw Exception("Failed to load Cart");
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<CartResponse?> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndPoint.updateCart,
        headers: {'Authorization': "Bearer ${SharedPref.getUserData()?.token}"},
        data: {"cart_item_id": cartItemId, "quantity": quantity},
      );
      if (res.statusCode == 201) {
        var data = CartResponse.fromJson(res.data);
        return data;
      } else {
        throw Exception("Failed to load Cart");
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> placeOrder(PlaceOrderParams params) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndPoint.placeOrder,
        headers: {'Authorization': "Bearer ${SharedPref.getUserData()?.token}"},
        data: params.toJson(),
      );
      if (res.statusCode == 201) {
        return true;
      } else {
        throw Exception("Failed to load Cart");
      }
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  // static saveListToLocal(List<CartProduct> CartIds) {
  //   if (CartIds.isEmpty) {
  //     SharedPref.saveCart([]);
  //   } else {
  //     List<int> bookIds = [];
  //     for (var id in CartIds) {
  //       bookIds.add(id.id ?? 0);
  //     }
  //     SharedPref.saveCart(bookIds);
  //   }
  // }
}
