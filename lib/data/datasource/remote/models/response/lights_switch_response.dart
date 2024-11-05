// To parse this JSON data, do
//
//     final getDevicesResponse = getDevicesResponseFromJson(jsonString);

import 'dart:convert';

GetDevicesResponse getDevicesResponseFromJson(String str) => GetDevicesResponse.fromJson(json.decode(str));

String getDevicesResponseToJson(GetDevicesResponse data) => json.encode(data.toJson());

class GetDevicesResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final List<Datum>? data;

  GetDevicesResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory GetDevicesResponse.fromJson(Map<String, dynamic> json) => GetDevicesResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final String? id;
  final String? manufacturer;
  final bool? isDeleted;
  final String? channelid;
  final String? deviceid;
  final String? type;
  final String? status;
  final String? model;
  final int? isconfigured;
  final int? onlinestate;
  final String? userid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? city;
  final String? country;
  final String? deviceicon;
  final String? friendlyname;
  final String? latlng;
  final String? location;
  final String? name;
  final int? regtime;
  final String? room;
  final String? hotelId;
  final String? roomId;

  Datum({
    this.id,
    this.manufacturer,
    this.isDeleted,
    this.channelid,
    this.deviceid,
    this.type,
    this.status,
    this.model,
    this.isconfigured,
    this.onlinestate,
    this.userid,
    this.createdAt,
    this.updatedAt,
    this.city,
    this.country,
    this.deviceicon,
    this.friendlyname,
    this.latlng,
    this.location,
    this.name,
    this.regtime,
    this.room,
    this.hotelId,
    this.roomId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    manufacturer: json["manufacturer"],
    isDeleted: json["isDeleted"],
    channelid: json["channelid"],
    deviceid: json["deviceid"],
    type: json["type"],
    status: json["status"],
    model: json["model"],
    isconfigured: json["isconfigured"],
    onlinestate: json["onlinestate"],
    userid: json["userid"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    city: json["city"],
    country: json["country"],
    deviceicon: json["deviceicon"],
    friendlyname: json["friendlyname"],
    latlng: json["latlng"],
    location: json["location"],
    name: json["name"],
    regtime: json["regtime"],
    room: json["room"],
    hotelId: json["hotelId"],
    roomId: json["roomId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "manufacturer": manufacturer,
    "isDeleted": isDeleted,
    "channelid": channelid,
    "deviceid": deviceid,
    "type": type,
    "status": status,
    "model": model,
    "isconfigured": isconfigured,
    "onlinestate": onlinestate,
    "userid": userid,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "city": city,
    "country": country,
    "deviceicon": deviceicon,
    "friendlyname": friendlyname,
    "latlng": latlng,
    "location": location,
    "name": name,
    "regtime": regtime,
    "room": room,
    "hotelId": hotelId,
    "roomId": roomId,
  };
}
