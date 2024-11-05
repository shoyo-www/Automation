import 'dart:convert';

UpdateDeviceResponse updateDeviceResponseFromJson(String str) => UpdateDeviceResponse.fromJson(json.decode(str));


class UpdateDeviceResponse {
  final String? msg;

  UpdateDeviceResponse({
    this.msg,
  });

  factory UpdateDeviceResponse.fromJson(Map<String, dynamic> json) => UpdateDeviceResponse(
    msg: json["msg"],
  );

}
