import 'errors.dart';

class AuthResponse {
  List<dynamic>? data;
  String? message;
  Errors? errors;
  int? status;

  AuthResponse({this.data, this.message, this.errors, this.status});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    data: json['data'] as List<dynamic>?,
    message: json['message'] as String?,
    errors: json['errors'] == null
        ? null
        : Errors.fromJson(json['errors'] as Map<String, dynamic>),
    status: json['status'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'data': data,
    'message': message,
    'errors': errors?.toJson(),
    'status': status,
  };
}
