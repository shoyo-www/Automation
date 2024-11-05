// To parse this JSON data, do
//
//     final facilityTypeResponse = facilityTypeResponseFromJson(jsonString);

import 'dart:convert';

FacilityTypeResponse facilityTypeResponseFromJson(String str) => FacilityTypeResponse.fromJson(json.decode(str));

String facilityTypeResponseToJson(FacilityTypeResponse data) => json.encode(data.toJson());

class FacilityTypeResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  FacilityTypeResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory FacilityTypeResponse.fromJson(Map<String, dynamic> json) => FacilityTypeResponse(
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
  final List<HotelFacilityTypesDatum>? hotelFacilityTypesData;
  final int? totalCount;

  Data({
    this.hotelFacilityTypesData,
    this.totalCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    hotelFacilityTypesData: json["hotelFacilityTypesData"] == null ? [] : List<HotelFacilityTypesDatum>.from(json["hotelFacilityTypesData"]!.map((x) => HotelFacilityTypesDatum.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "hotelFacilityTypesData": hotelFacilityTypesData == null ? [] : List<dynamic>.from(hotelFacilityTypesData!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class HotelFacilityTypesDatum {
  final String? id;
  final List<int>? days;
  final bool? isDeleted;
  final String? hotelId;
  final String? facilityId;
  final String? name;
  final String? email;
  final String? cuisine;
  final String? description;
  final int? shopNumber;
  final String? phoneNumber;
  final String? image;
  final String? area;
  final String? location;
  final String? locationlink;
  final String? startTime;
  final String? endTime;
  final int? numberOfGuests;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? pricing;

  HotelFacilityTypesDatum({
    this.id,
    this.days,
    this.isDeleted,
    this.hotelId,
    this.facilityId,
    this.name,
    this.email,
    this.cuisine,
    this.description,
    this.shopNumber,
    this.phoneNumber,
    this.image,
    this.area,
    this.location,
    this.locationlink,
    this.startTime,
    this.endTime,
    this.numberOfGuests,
    this.createdAt,
    this.updatedAt,
    this.pricing,
  });

  factory HotelFacilityTypesDatum.fromJson(Map<String, dynamic> json) => HotelFacilityTypesDatum(
    id: json["_id"],
    days: json["days"] == null ? [] : List<int>.from(json["days"]!.map((x) => x)),
    isDeleted: json["isDeleted"],
    hotelId: json["hotelId"],
    facilityId: json["facilityId"],
    name: json["name"],
    email: json["email"],
    cuisine: json["cuisine"],
    description: json["description"],
    shopNumber: json["shopNumber"],
    phoneNumber: json["phoneNumber"],
    image: json["image"],
    area: json["area"],
    location: json["location"],
    locationlink: json["locationlink"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    numberOfGuests: json["numberOfGuests"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    pricing: json["pricing"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "days": days == null ? [] : List<dynamic>.from(days!.map((x) => x)),
    "isDeleted": isDeleted,
    "hotelId": hotelId,
    "facilityId": facilityId,
    "name": name,
    "email": email,
    "cuisine": cuisine,
    "description": description,
    "shopNumber": shopNumber,
    "phoneNumber": phoneNumber,
    "image": image,
    "area": area,
    "location": location,
    "locationlink": locationlink,
    "startTime": startTime,
    "endTime": endTime,
    "numberOfGuests": numberOfGuests,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "pricing": pricing,
  };
}
