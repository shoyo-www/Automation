import 'dart:convert';

GetServiceResponse getFacilityResponseFromJson(String str) => GetServiceResponse.fromJson(json.decode(str));

class GetServiceResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  GetServiceResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory GetServiceResponse.fromJson(Map<String, dynamic> json) => GetServiceResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  final List<ServiceDatum>? serviceData;
  final int? totalCount;

  Data({
    this.serviceData,
    this.totalCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    serviceData: json["serviceData"] == null ? [] : List<ServiceDatum>.from(json["serviceData"]!.map((x) => ServiceDatum.fromJson(x))),
    totalCount: json["totalCount"],
  );

}

class ServiceDatum {
  final List<SubCategoriesId>? subCategoriesIds;
  final bool? isDeleted;
  final bool? isAvailable;
  final String? id;
  final String? hotelId;
  final String? name;
  final String? description;
  final String? images;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ServiceDatum({
    this.subCategoriesIds,
    this.isDeleted,
    this.isAvailable,
    this.id,
    this.hotelId,
    this.name,
    this.description,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  factory ServiceDatum.fromJson(Map<String, dynamic> json) => ServiceDatum(
    subCategoriesIds: json["subCategoriesIds"] == null ? [] : List<SubCategoriesId>.from(json["subCategoriesIds"]!.map((x) => SubCategoriesId.fromJson(x))),
    isDeleted: json["isDeleted"],
    isAvailable: json["isAvailable"],
    id: json["_id"],
    hotelId: json["hotelId"],
    name: json["name"],
    description: json["description"],
    images: json["images"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

}



class SubCategoriesId {
  final bool? isAvailable;
  int isPending;
  final String? id;
  final String? name;
  final String? description;
  final String? icon;
  final String? hotelFacilityId;

  SubCategoriesId({
    this.isAvailable,
    this.id,
    this.name,
    this.description,
    this.icon,
    this.hotelFacilityId,
    this.isPending = 0
  });

  factory SubCategoriesId.fromJson(Map<String, dynamic> json) => SubCategoriesId(
    isAvailable: json["isAvailable"],
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    icon: json["icon"],
    hotelFacilityId: json["hotelFacilityId"],
  );

  Map<String, dynamic> toJson() => {
    "isAvailable": isAvailable,
    "_id": id,
    "name": name,
    "description": description,
    "icon": icon,
    "hotelFacilityId": hotelFacilityId,
  };
}

