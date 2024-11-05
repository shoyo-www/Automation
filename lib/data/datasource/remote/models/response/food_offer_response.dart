import 'dart:convert';

FoodOfferResponse foodOfferResponseFromJson(String str) => FoodOfferResponse.fromJson(json.decode(str));


class FoodOfferResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  FoodOfferResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory FoodOfferResponse.fromJson(Map<String, dynamic> json) => FoodOfferResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  final List<CouponDatum>? couponData;
  final int? totalCount;

  Data({
    this.couponData,
    this.totalCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    couponData: json["couponData"] == null ? [] : List<CouponDatum>.from(json["couponData"]!.map((x) => CouponDatum.fromJson(x))),
    totalCount: json["totalCount"],
  );

}

class CouponDatum {
  final String? id;
  final List<String>? applicableItems;
  final bool? isDeleted;
  final String? hotelId;
  final String? name;
  final String? code;
  final String? description;
  final int? discountType;
  final int? discountValue;
  final int? minimumPurchaseAmount;
  final int? codeType;
  final DateTime? expireDate;
  final DateTime? startDate;
  final int? usageLimits;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ApplicableItemsDatum>? applicableItemsData;

  CouponDatum({
    this.id,
    this.applicableItems,
    this.isDeleted,
    this.hotelId,
    this.name,
    this.code,
    this.description,
    this.discountType,
    this.discountValue,
    this.minimumPurchaseAmount,
    this.codeType,
    this.expireDate,
    this.startDate,
    this.usageLimits,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.applicableItemsData,
  });

  factory CouponDatum.fromJson(Map<String, dynamic> json) => CouponDatum(
    id: json["_id"],
    applicableItems: json["applicableItems"] == null ? [] : List<String>.from(json["applicableItems"]!.map((x) => x)),
    isDeleted: json["isDeleted"],
    hotelId: json["hotelId"],
    name: json["name"],
    code: json["code"],
    description: json["description"],
    discountType: json["discountType"],
    discountValue: json["discountValue"],
    minimumPurchaseAmount: json["minimumPurchaseAmount"],
    codeType: json["codeType"],
    expireDate: json["expireDate"] == null ? null : DateTime.parse(json["expireDate"]),
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    usageLimits: json["usageLimits"],
    image: json["image"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    applicableItemsData: json["applicableItemsData"] == null ? [] : List<ApplicableItemsDatum>.from(json["applicableItemsData"]!.map((x) => ApplicableItemsDatum.fromJson(x))),
  );

}

class ApplicableItemsDatum {
  final String? id;
  final List<String>? inGridients;
  final List<dynamic>? choiceOfAddOn;
  final bool? isAvailable;
  final bool? isDeleted;
  final String? hotelId;
  final String? name;
  final String? imageUrl;
  final String? description;
  final int? price;
  final int? type;
  final String? foodCategoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ApplicableItemsDatum({
    this.id,
    this.inGridients,
    this.choiceOfAddOn,
    this.isAvailable,
    this.isDeleted,
    this.hotelId,
    this.name,
    this.imageUrl,
    this.description,
    this.price,
    this.type,
    this.foodCategoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory ApplicableItemsDatum.fromJson(Map<String, dynamic> json) => ApplicableItemsDatum(
    id: json["_id"],
    inGridients: json["inGridients"] == null ? [] : List<String>.from(json["inGridients"]!.map((x) => x)),
    choiceOfAddOn: json["choiceOfAddOn"] == null ? [] : List<dynamic>.from(json["choiceOfAddOn"]!.map((x) => x)),
    isAvailable: json["isAvailable"],
    isDeleted: json["isDeleted"],
    hotelId: json["hotelId"],
    name: json["name"],
    imageUrl: json["imageURL"],
    description: json["description"],
    price: json["price"],
    type: json["type"],
    foodCategoryId: json["foodCategoryId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

}
