
import 'dart:convert';

String updateDeviceRequestToJson(UpdateDeviceRequest data) => json.encode(data.toJson());

class UpdateDeviceRequest {
  final String? channelid;
  final String? action;
  final String? level;
  final String? temp;
  final String? openPercent;
  final String? color;
  final String? model;
  final String? actionlog;

  UpdateDeviceRequest({
    this.channelid,
    this.action,
    this.level,
    this.temp,
    this.openPercent,
    this.color,
    this.model,
    this.actionlog,
  });


  Map<String, dynamic> toJson() => {
    "channelid": channelid,
    "action": action,
    "level": level,
    "openPercent": openPercent,
    "color": color,
    "model": model,
    "actionlog": actionlog,
  };
}
