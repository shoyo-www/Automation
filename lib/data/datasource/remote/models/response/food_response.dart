
import 'dart:convert';

FoodResponse foodResponseFromJson(String str) => FoodResponse.fromJson(json.decode(str));

class FoodResponse {
  final int? statusCode;
  final bool? status;
  final String? message;
  final String? type;
  final Data? data;

  FoodResponse({
    this.statusCode,
    this.status,
    this.message,
    this.type,
    this.data,
  });

  factory FoodResponse.fromJson(Map<String, dynamic> json) => FoodResponse(
    statusCode: json["statusCode"],
    status: json["status"],
    message: json["message"],
    type: json["type"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );


}

class Data {
  final List<Food>? data;
  final int? totalCount;

  Data({
    this.data,
    this.totalCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: json["data"] == null ? [] : List<Food>.from(json["data"]!.map((x) => Food.fromJson(x))),
    totalCount: json["totalCount"],
  );

}

class Food {
  final String? id;
  final String? hotelId;
  final String? name;
  final String? description;
  final List<FoodsInCategory>? foodsInCategories;
  final List<String>? foodsInCategory;

  Food({
    this.id,
    this.hotelId,
    this.name,
    this.description,
    this.foodsInCategories,
    this.foodsInCategory,
  });

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    id: json["_id"],
    hotelId: json["hotelId"]!,
    name: json["name"],
    description: json["description"],
    foodsInCategories: json["foodsInCategories"] == null ? [] : List<FoodsInCategory>.from(json["foodsInCategories"]!.map((x) => FoodsInCategory.fromJson(x))),
    foodsInCategory: json["foodsInCategory"] == null ? [] : List<String>.from(json["foodsInCategory"]!.map((x) => x)),
  );

}

class FoodsInCategory {
  final String? id;
  final int? count;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? foodCategoryId;
  final String? kcal;
  int quantity;

  FoodsInCategory({
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
    this.createdAt,
    this.updatedAt,
    this.foodCategoryId,
    this.count,
    this.kcal,
    this.quantity = 0
  });

  factory FoodsInCategory.fromJson(Map<String, dynamic> json) => FoodsInCategory(
    id: json["_id"],
    inGridients: json["inGridients"] == null ? [] : List<String>.from(json["inGridients"]!.map((x) => x)),
    choiceOfAddOn: json["choiceOfAddOn"] == null ? [] : List<String>.from(json["choiceOfAddOn"]!.map((x) => x)),
    isAvailable: json["isAvailable"],
    isDeleted: json["isDeleted"],
    hotelId: json["hotelId"]!,
    name: json["name"],
    imageUrl: json["imageURL"],
    description: json["description"],
    price: json["price"],
    type: json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    foodCategoryId: json["foodCategoryId"],
    kcal: json["kcal"]
  );

}

