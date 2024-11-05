import 'package:dartz/dartz.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/food_order_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/food_offer_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/food_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_single_food.dart';

abstract class FoodRepository {
  Future<Either<Failure, FoodResponse>> getFood(String hotelId);
  Future<Either<Failure, GetSingleFoodResponse>> getSingleFoodDetail(String hotelId,String foodId);
  Future<Either<Failure, GetSingleFoodResponse>> foodOrder(FoodOrderRequest req);
  Future<Either<Failure, FoodOfferResponse>> foodOffer(String hotel);
}