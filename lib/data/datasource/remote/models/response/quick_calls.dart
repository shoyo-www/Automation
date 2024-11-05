import 'dart:convert';

GetQuickCalls getQuickCallsFromJson(String str) => GetQuickCalls.fromJson(json.decode(str));

String getQuickCallsToJson(GetQuickCalls data) => json.encode(data.toJson());

class GetQuickCalls {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final List<QuickCalls>? data;

  GetQuickCalls({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory GetQuickCalls.fromJson(Map<String, dynamic> json) => GetQuickCalls(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? [] : List<QuickCalls>.from(json["data"]!.map((x) => QuickCalls.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "type": type,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class QuickCalls {
  final String? id;
  final bool? isDeleted;
  final String? hotelId;
  final String? name;
  final String? emoji;
  final String? description;
  final int? redirectTypes;
  final String? supportNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? foodCategoryId;

  QuickCalls({
    this.id,
    this.isDeleted,
    this.hotelId,
    this.name,
    this.emoji,
    this.description,
    this.redirectTypes,
    this.supportNumber,
    this.createdAt,
    this.updatedAt,
    this.foodCategoryId,
  });

  factory QuickCalls.fromJson(Map<String, dynamic> json) => QuickCalls(
    id: json["_id"],
    isDeleted: json["isDeleted"],
    hotelId: json["hotelId"],
    name: json["name"],
    emoji: json["emoji"],
    description: json["description"],
    redirectTypes: json["redirectTypes"],
    supportNumber: json["supportNumber"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    foodCategoryId: json["foodCategoryId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "isDeleted": isDeleted,
    "hotelId": hotelId,
    "name": name,
    "emoji": emoji,
    "description": description,
    "redirectTypes": redirectTypes,
    "supportNumber": supportNumber,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "foodCategoryId": foodCategoryId,
  };
}
