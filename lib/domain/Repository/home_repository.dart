import 'package:dartz/dartz.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/update_device_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/lights_switch_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/quick_calls.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/room_scence_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/update_device_response.dart';

abstract class HomeRepository {
  Future<Either<Failure, RoomSceneResponse>> getRoomScene(String hotelId);
  Future<Either<Failure, GetQuickCalls>> quickCalls(String hotelId);
  Future<Either<Failure, GetDevicesResponse>> getLightSwitch(String userId);
  Future<Either<Failure, UpdateDeviceResponse>> updateDevices(UpdateDeviceRequest request);
}