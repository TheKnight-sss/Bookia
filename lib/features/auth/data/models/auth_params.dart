import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class AuthParams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;
  File? profileImage;

  AuthParams({this.name, this.email, this.password, this.passwordConfirmation});

  factory AuthParams.fromJson(Map<String, dynamic> json) {
    return AuthParams(
      name: json['name'],
      email: json["email"],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };
  }

  FormData toFormData() {
    return FormData.fromMap({
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "image": MultipartFile.fromFileSync(profileImage!.path,
          filename: profileImage!.path.split('/').last),
  });
  }

  // String convertIntoBase64(File file) {
  //   List<int> imageBytes = file.readAsBytesSync();
  //   String base64File = base64Encode(imageBytes);
  //   return base64File;
  // }
}
