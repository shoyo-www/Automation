import 'dart:convert';

CommonResponse commonResponseFromJson(String str) => CommonResponse.fromJson(json.decode(str));


class CommonResponse {
  final bool status;
  final int statusCode;
  final String type;
  final String message;

  CommonResponse({
    required this.status,
    required this.statusCode,
    required this.type,
    required this.message,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
    status: json["status"],
    statusCode: json["statusCode"],
    type: json["type"],
    message: json["message"],
  );

}
