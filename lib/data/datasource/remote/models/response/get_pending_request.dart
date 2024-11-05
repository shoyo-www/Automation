
import 'dart:convert';

GetPendingRequestResponse getPendingRequestResponseFromJson(String str) => GetPendingRequestResponse.fromJson(json.decode(str));


class GetPendingRequestResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  GetPendingRequestResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory GetPendingRequestResponse.fromJson(Map<String, dynamic> json) => GetPendingRequestResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );


}

class Data {
  final List<ListElement>? list;
  final int? totalCount;
  final int? allRequestCount;
  final int? pendingRequestCount;
  final int? inProgressRequestCount;
  final int? cancelRequestCount;
  final int? completeRequestCount;

  Data({
    this.list,
    this.totalCount,
    this.allRequestCount,
    this.pendingRequestCount,
    this.inProgressRequestCount,
    this.cancelRequestCount,
    this.completeRequestCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    list: json["list"] == null ? [] : List<ListElement>.from(json["list"]!.map((x) => ListElement.fromJson(x))),
    totalCount: json["totalCount"],
    allRequestCount: json["allRequestCount"],
    pendingRequestCount: json["pendingRequestCount"],
    inProgressRequestCount: json["inProgressRequestCount"],
    cancelRequestCount: json["cancelRequestCount"],
    completeRequestCount: json["completeRequestCount"],
  );


}

class ListElement {
  final String? id;
  final int? status;
  final String? hotelFacilityId;
  final String? description;
  final String? customerId;
  final DateTime? requestedAt;
  final String? subCategoryId;
  final int? roomNumber;
  final String? customerName;
  final String? facilityName;

  ListElement({
    this.id,
    this.status,
    this.hotelFacilityId,
    this.description,
    this.customerId,
    this.requestedAt,
    this.subCategoryId,
    this.roomNumber,
    this.customerName,
    this.facilityName,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    status: json["status"],
    hotelFacilityId: json["hotelFacilityId"],
    description: json["description"],
    customerId: json["customerId"],
    requestedAt: json["requestedAt"] == null ? null : DateTime.parse(json["requestedAt"]),
    subCategoryId: json["subCategoryId"],
    roomNumber: json["roomNumber"],
    customerName: json["customerName"],
    facilityName: json["facilityName"],
  );

}
