class Errors {
  List<String>? email;

  Errors({this.email});

  factory Errors.fromJson(Map<String, dynamic> json) =>
      Errors(email: json['email'] as List<String>?);

  Map<String, dynamic> toJson() => {'email': email};
}
