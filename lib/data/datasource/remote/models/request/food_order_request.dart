import 'dart:convert';

String foodOrderRequestToJson(FoodOrderRequest data) => json.encode(data.toJson());

class FoodOrderRequest {
  final String? hotelId;
  final List<FoodItem>? foodItems;
  final String? coupon;
  final String? deliveryAddress;

  FoodOrderRequest({
    this.hotelId,
    this.foodItems,
    this.coupon,
    this.deliveryAddress,
  });



  Map<String, dynamic> toJson() => {
    "hotelId": hotelId,
    "foodItems": foodItems == null ? [] : List<dynamic>.from(foodItems!.map((x) => x.toJson())),
    // "coupon": coupon,
    "deliveryAddress": deliveryAddress,
  };
}

class FoodItem {
  final String? foodId;
  int? quantity;
  int? price;
  String? image;
  String? addon;
  int? type;
  String? name;


  FoodItem({
    this.foodId,
    this.quantity = 1,
    this.price,
    this.image,
    this.type,
    this.addon,
    this.name
  });


  Map<String, dynamic> toJson() => {
    "foodId": foodId,
    "quantity": quantity,
    "price": price,
  };
}
