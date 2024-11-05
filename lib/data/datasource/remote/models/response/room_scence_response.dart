import 'dart:convert';

RoomSceneResponse roomSceneResponseFromJson(String str) => RoomSceneResponse.fromJson(json.decode(str));


class RoomSceneResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final List<RoomScene>? data;

  RoomSceneResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory RoomSceneResponse.fromJson(Map<String, dynamic> json) => RoomSceneResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? [] : List<RoomScene>.from(json["data"]!.map((x) => RoomScene.fromJson(x))),
  );

}

class RoomScene {
  final String? id;
  final bool? isDeleted;
  final String? hotelId;
  final String? name;
  final String? icon;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  bool isSelected;

  RoomScene({
    this.id,
    this.isDeleted,
    this.hotelId,
    this.name,
    this.icon,
    this.createdAt,
    this.updatedAt,
    this.isSelected = false
  });

  factory RoomScene.fromJson(Map<String, dynamic> json) => RoomScene(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    hotelId: json["hotelId"],
    name: json["name"],
    icon: json["icon"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

}
