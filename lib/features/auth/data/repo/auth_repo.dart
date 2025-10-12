import 'dart:developer';

import 'package:bookia/core/Services/dio/api_endpoint.dart';
import 'package:bookia/core/Services/dio/dio_provider.dart';
import 'package:bookia/core/Services/local_helper.dart';
import 'package:bookia/features/auth/data/models/auth_params.dart';
import 'package:bookia/features/auth/data/models/auth_response/auth_response.dart';

class AuthRepo {
  static Future<AuthResponse?> register(AuthParams params) async {
    try {
      var res = await DioProvider.post(
        endpoint: ApiEndPoint.register,
        data: params.toJson(),
      );
      if (res.statusCode == 201) {
        var body = res.data;
        var userObj = AuthResponse.fromJson(body);
        SharedPref.saveUserData(userObj.data);
        return userObj;
      } else {
        return null;
      }
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  static login(AuthParams params) async {
    var res = await DioProvider.post(
      endpoint: ApiEndPoint.login,
      data: params.toJson(),
    );
    if (res.statusCode == 200) {
      // Succsess
    } else {
      // error
    }
  }
}
