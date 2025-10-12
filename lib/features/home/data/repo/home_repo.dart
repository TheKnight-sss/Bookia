import 'dart:developer';
import 'package:bookia/core/Services/dio/api_endpoint.dart';
import 'package:bookia/core/Services/dio/dio_provider.dart';
import 'package:bookia/features/home/data/model/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/model/slider_respones/slider_respones.dart';

class HomeRepo {
  static Future<BestSellerResponse?> getBestSeller() async {
    try {
      var res = await DioProvider.get(endpoint: ApiEndPoint.productsbestseller);

      if (res.statusCode == 200) {
        return BestSellerResponse.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<SliderRespones?> getSliders() async {
    try {
      var res = await DioProvider.get(endpoint: ApiEndPoint.slider);

      if (res.statusCode == 200) {
        return SliderRespones.fromJson(res.data);
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
