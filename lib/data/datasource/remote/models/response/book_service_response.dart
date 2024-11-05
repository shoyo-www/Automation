import 'dart:convert';

BookServiceResponse bookServiceResponseFromJson(String str) => BookServiceResponse.fromJson(json.decode(str));


class BookServiceResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final List<Datum>? data;

  BookServiceResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory BookServiceResponse.fromJson(Map<String, dynamic> json) => BookServiceResponse(
    statusCode: json["statusCode"] as int?,
    status: json["status"] as bool?,
    message: json["message"] as String?,
    type: json["type"] as String?,
    data: json["data"] != null
        ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
        : null,
  );
}

class Datum {
  final int? status;
  final bool? isDeleted;
  final String? id;
  final String? hotelId;
  final String? hotelFacilityId;
  final String? description;
  final String? customerId;
  final DateTime? requestedAt;
  final String? subCategoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.status,
    this.isDeleted,
    this.id,
    this.hotelId,
    this.hotelFacilityId,
    this.description,
    this.customerId,
    this.requestedAt,
    this.subCategoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    status: json["status"] as int?,
    isDeleted: json["isDeleted"] as bool?,
    id: json["_id"] as String?,
    hotelId: json["hotelId"] as String?,
    hotelFacilityId: json["hotelFacilityId"] as String?,
    description: json["description"] as String?,
    customerId: json["customerId"] as String?,
    requestedAt: json["requestedAt"] != null ? DateTime.parse(json["requestedAt"]) : null,
    subCategoryId: json["subCategoryId"] as String?,
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
  );
}
