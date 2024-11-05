// To parse this JSON data, do
//
//     final getSingleFoodResponse = getSingleFoodResponseFromJson(jsonString);

import 'dart:convert';

GetSingleFoodResponse getSingleFoodResponseFromJson(String str) => GetSingleFoodResponse.fromJson(json.decode(str));

String getSingleFoodResponseToJson(GetSingleFoodResponse data) => json.encode(data.toJson());

class GetSingleFoodResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  GetSingleFoodResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory GetSingleFoodResponse.fromJson(Map<String, dynamic> json) => GetSingleFoodResponse(
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
  final List<FoodDatum>? foodData;
  final int? totalCount;

  Data({
    this.foodData,
    this.totalCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    foodData: json["foodData"] == null ? [] : List<FoodDatum>.from(json["foodData"]!.map((x) => FoodDatum.fromJson(x))),
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "foodData": foodData == null ? [] : List<dynamic>.from(foodData!.map((x) => x.toJson())),
    "totalCount": totalCount,
  };
}

class FoodDatum {
  final String? id;
  final List<String>? choiceOfAddOn;
  final bool? isAvailable;
  final String? hotelId;
  final String? name;
  final String? description;
  final int? price;
  final int? type;
  final String? imageUrl;
  final String? foodCategoryId;
  final List<AddOnDetail>? addOnDetails;
  final String? foodCategoryName;

  FoodDatum({
    this.id,
    this.choiceOfAddOn,
    this.isAvailable,
    this.hotelId,
    this.name,
    this.description,
    this.price,
    this.type,
    this.imageUrl,
    this.foodCategoryId,
    this.addOnDetails,
    this.foodCategoryName,
  });

  factory FoodDatum.fromJson(Map<String, dynamic> json) => FoodDatum(
    id: json["_id"],
    choiceOfAddOn: json["choiceOfAddOn"] == null ? [] : List<String>.from(json["choiceOfAddOn"]!.map((x) => x)),
    isAvailable: json["isAvailable"],
    hotelId: json["hotelId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    type: json["type"],
    imageUrl: json["imageURL"],
    foodCategoryId: json["foodCategoryId"],
    addOnDetails: json["addOnDetails"] == null ? [] : List<AddOnDetail>.from(json["addOnDetails"]!.map((x) => AddOnDetail.fromJson(x))),
    foodCategoryName: json["foodCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "choiceOfAddOn": choiceOfAddOn == null ? [] : List<dynamic>.from(choiceOfAddOn!.map((x) => x)),
    "isAvailable": isAvailable,
    "hotelId": hotelId,
    "name": name,
    "description": description,
    "price": price,
    "type": type,
    "foodCategoryId": foodCategoryId,
    "addOnDetails": addOnDetails == null ? [] : List<dynamic>.from(addOnDetails!.map((x) => x.toJson())),
    "foodCategoryName": foodCategoryName,
  };
}

class AddOnDetail {
  final String? id;
  final List<String>? inGridients;
  final List<String>? choiceOfAddOn;
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

  AddOnDetail({
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

  factory AddOnDetail.fromJson(Map<String, dynamic> json) => AddOnDetail(
    id: json["_id"],
    inGridients: json["inGridients"] == null ? [] : List<String>.from(json["inGridients"]!.map((x) => x)),
    choiceOfAddOn: json["choiceOfAddOn"] == null ? [] : List<String>.from(json["choiceOfAddOn"]!.map((x) => x)),
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

  Map<String, dynamic> toJson() => {
    "_id": id,
    "inGridients": inGridients == null ? [] : List<dynamic>.from(inGridients!.map((x) => x)),
    "choiceOfAddOn": choiceOfAddOn == null ? [] : List<dynamic>.from(choiceOfAddOn!.map((x) => x)),
    "isAvailable": isAvailable,
    "isDeleted": isDeleted,
    "hotelId": hotelId,
    "name": name,
    "imageURL": imageUrl,
    "description": description,
    "price": price,
    "type": type,
    "foodCategoryId": foodCategoryId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
