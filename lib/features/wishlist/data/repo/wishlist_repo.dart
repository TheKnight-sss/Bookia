import 'dart:developer';

import 'package:bookia/core/Services/dio/api_endpoint.dart';
import 'package:bookia/core/Services/dio/dio_provider.dart';
import 'package:bookia/core/Services/local/local_helper.dart';
import 'package:bookia/features/wishlist/data/model/wish_list_response/datum.dart';
import 'package:bookia/features/wishlist/data/model/wish_list_response/wish_list_response.dart';

class WishlistRepo {
  Future<WishListResponse?> getWishList() async {
    try {
      var res = await DioProvider.get(
        endpoint: ApiEndPoint.wishlist,
        headers: {'Authorization': "Bearer ${SharedPref.getUserData()?.token}"},
      );
      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveListToLocal(data.data?.data ?? []);
        return data;
      } else {
        throw Exception("Failed to load wishlist");
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> addToWishList({
    required int productId,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndPoint.addToWishlist,
        headers: {'Authorization': "Bearer ${SharedPref.getUserData()?.token}"},
        data: {"product_id": productId},
      );
      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveListToLocal(data.data?.data ?? []);
        return data;
      } else {
        throw Exception("Failed to load wishlist");
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<WishListResponse?> removeFromWishList({
    required int productId,
  }) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndPoint.removeFromWishlist,
        headers: {'Authorization': "Bearer ${SharedPref.getUserData()?.token}"},
        data: {"product_id": productId},
      );
      if (res.statusCode == 200) {
        var data = WishListResponse.fromJson(res.data);
        saveListToLocal(data.data?.data ?? []);
        return data;
      } else {
        throw Exception("Failed to load wishlist");
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static saveListToLocal(List<WishListProduct> wishListIds) {
    if (wishListIds.isEmpty) {
      SharedPref.saveWishList([]);
    } else {
      List<int> bookIds = [];
      for (var id in wishListIds) {
        bookIds.add(id.id ?? 0);
      }
      SharedPref.saveWishList(bookIds);
    }
  }
}
