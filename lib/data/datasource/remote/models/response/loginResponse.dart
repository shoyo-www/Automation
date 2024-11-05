import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  LoginResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  final String? otp;
  final String? token;

  Data({
    this.otp,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    otp: json["otp"],
    token: json["token"],
  );

}
