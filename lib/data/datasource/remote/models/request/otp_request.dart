import 'dart:convert';

String otpResponseToJson(OtpRequest data) => json.encode(data.toJson());

class OtpRequest {
  final String otp;

  OtpRequest({
    required this.otp,
  });

  Map<String, dynamic> toJson() => {
    "otp": otp,
  };
}
