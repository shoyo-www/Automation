// To parse this JSON data, do
//
//     final getFacilitiesResponse = getFacilitiesResponseFromJson(jsonString);

import 'dart:convert';

GetFacilitiesResponse getFacilitiesResponseFromJson(String str) => GetFacilitiesResponse.fromJson(json.decode(str));

String getFacilitiesResponseToJson(GetFacilitiesResponse data) => json.encode(data.toJson());

class GetFacilitiesResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  GetFacilitiesResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory GetFacilitiesResponse.fromJson(Map<String, dynamic> json) => GetFacilitiesResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statusCode": statusCode,
    "status": status,
    "message": message,
    "type": type,
    "data": data?.toJson(),
  };
}

class Data {
  final List<FacilityDatum>? facilityData;
  final int? totalCount;

  Data({
    this.facilityData,
    this.totalCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    facilityData: json["facilityData"] == null ? [] : List<FacilityDatum>.from(json["facilityData"]!.map((x) => FacilityDatum.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "facilityData": facilityData == null ? [] : List<dynamic>.from(facilityData!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class FacilityDatum {
  final List<Type>? types;
  final bool? isDeleted;
  final String? id;
  final String? hotelId;
  final String? name;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  FacilityDatum({
    this.types,
    this.isDeleted,
    this.id,
    this.hotelId,
    this.name,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory FacilityDatum.fromJson(Map<String, dynamic> json) => FacilityDatum(
    types: json["types"] == null ? [] : List<Type>.from(json["types"]!.map((x) => Type.fromJson(x))),
    isDeleted: json["isDeleted"],
    id: json["_id"],
    hotelId: json["hotelId"],
    name: json["name"],
    imageUrl: json["imageUrl"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x.toJson())),
    "isDeleted": isDeleted,
    "_id": id,
    "hotelId": hotelId,
    "name": name,
    "imageUrl": imageUrl,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Type {
  final List<int>? days;
  final bool? isDeleted;
  final String? id;
  final String? hotelId;
  final String? facilityId;
  final String? name;
  final String? description;
  final int? capacity;
  final String? phoneNumber;
  final String? image;
  final String? area;
  final String? startTime;
  final String? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? email;
  final String? cuisine;
  final int? shopNumber;
  final String? location;
  final String? locationlink;
  final int? numberOfGuests;
  final int? pricing;

  Type({
    this.days,
    this.isDeleted,
    this.id,
    this.hotelId,
    this.facilityId,
    this.name,
    this.description,
    this.capacity,
    this.phoneNumber,
    this.image,
    this.area,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.cuisine,
    this.shopNumber,
    this.location,
    this.locationlink,
    this.numberOfGuests,
    this.pricing
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    days: json["days"] == null ? [] : List<int>.from(json["days"]!.map((x) => x)),
    isDeleted: json["isDeleted"],
    id: json["_id"],
    hotelId: json["hotelId"],
    facilityId: json["facilityId"],
    name: json["name"],
    description: json["description"],
    capacity: json["capacity"],
    phoneNumber: json["phoneNumber"],
    image: json["image"],
    area: json["area"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    email: json["email"],
    cuisine: json["cuisine"],
    shopNumber: json["shopNumber"],
    location: json["location"],
    locationlink: json["locationlink"],
    numberOfGuests: json["numberOfGuests"],
    pricing: json['pricing']
  );

  Map<String, dynamic> toJson() => {
    "days": days == null ? [] : List<dynamic>.from(days!.map((x) => x)),
    "isDeleted": isDeleted,
    "_id": id,
    "hotelId": hotelId,
    "facilityId": facilityId,
    "name": name,
    "description": description,
    "capacity": capacity,
    "phoneNumber": phoneNumber,
    "image": image,
    "area": area,
    "startTime": startTime,
    "endTime": endTime,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "email": email,
    "cuisine": cuisine,
    "shopNumber": shopNumber,
    "location": location,
    "locationlink": locationlink,
    "numberOfGuests": numberOfGuests,
  };
}
