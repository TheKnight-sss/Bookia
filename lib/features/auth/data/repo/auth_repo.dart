import 'package:bookia/core/Services/dio/api_endpoint.dart';
import 'package:bookia/core/Services/dio/dio_provider.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  register(
    String email,
    String password,
    String name,
    String confirmpass,
  ) async {
    var res = await DioProvider.post(
      path :ApiEndPoint.register,
      data: {
        "name": "Ahmed",
        "email": "sayed12301144@gmail.com",
        "password": "12345678",
        "password_confirmation": "12345678",
      },
    );
    if (res.statusCode == 201) {
      // Succes
    } else {
      // failed
    }
  }

  login() async {
    var res = await DioProvider.post(
      path: ApiEndPoint.login,
      data: {"email": "sayed332@gmail.com", "password": "12345678"},
    );
    if (res.statusCode == 200) {
      // Succsess
    }else{
      // error
    }
  }
}
