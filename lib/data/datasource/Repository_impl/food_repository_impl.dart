import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/food_order_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/food_offer_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/food_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_single_food.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/apis.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/dio/rest_client.dart';
import 'package:hotelautomationapp/domain/Repository/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final _restClient = Get.find<RestClient>();


  @override
  Future<Either<Failure, FoodResponse>> getFood(String hotelId) async {
    try {
      final response = await _restClient.get(url: Apis.foodCategory + hotelId);
      return Right(foodResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message, e.type));
    }
  }

  @override
  Future<Either<Failure, GetSingleFoodResponse>> getSingleFoodDetail(
      String hotelId, String foodId) async {
    try {
      final response = await _restClient.get(
          url: "${Apis.getFoodSingleDetail}$hotelId&foodIds=$foodId");
      return Right(getSingleFoodResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message, e.type));
    }
  }

  @override
  Future<Either<Failure, GetSingleFoodResponse>> foodOrder(
      FoodOrderRequest req) async {
    try {
      final response = await _restClient.post(
          url: Apis.foodOrder, request: req.toJson());
      return Right(getSingleFoodResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message, e.type));
    }
  }

  @override
  Future<Either<Failure, FoodOfferResponse>> foodOffer(String hotel) async {
    try {
      final response = await _restClient.get(url: Apis.getCoupon + hotel);
      return Right(foodOfferResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message, e.type));
    }
  }
}