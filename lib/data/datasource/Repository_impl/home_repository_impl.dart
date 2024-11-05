import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/update_device_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/lights_switch_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/quick_calls.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/room_scence_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/update_device_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/apis.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/dio/rest_client.dart';
import 'package:hotelautomationapp/domain/Repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, RoomSceneResponse>> getRoomScene(String hotelId) async {
    try {
      final response = await _restClient.get(url: Apis.getRoomScene + hotelId);
      return Right(roomSceneResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

  @override
  Future<Either<Failure, GetQuickCalls>> quickCalls(String hotelId) async {
    try {
      final response = await _restClient.get(url: Apis.quickCall + hotelId);
      return Right(getQuickCallsFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

  @override
  Future<Either<Failure, GetDevicesResponse>> getLightSwitch(String userId) async {
    try {
      final response = await _restClient.get(url: Apis.getLightSwitch + userId);
      return Right(getDevicesResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

  @override
  Future<Either<Failure, UpdateDeviceResponse>> updateDevices(UpdateDeviceRequest request) async {
    try {
      final response = await _restClient.post(url: Apis.updateDevice,request: request.toJson());
      return Right(updateDeviceResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

}