import 'dart:convert';

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  final String phoneNumber;

  LoginRequest({
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
    "phoneNumber": phoneNumber,
  };
}
