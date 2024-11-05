import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/book_service_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/book_service_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_facility_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_pending_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/apis.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/dio/rest_client.dart';
import 'package:hotelautomationapp/domain/Repository/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, GetServiceResponse>> getService(String hotelId) async {
    try {
      final response = await _restClient.get(url: "${Apis.geService}$hotelId");
      return Right(getFacilityResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

  @override
  Future<Either<Failure, GetPendingRequestResponse>> getPendingRequest(String hotelId) async {
    try {
      final response = await _restClient.get(url: "${Apis.getPendingRequestService}$hotelId");
      return Right(getPendingRequestResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

  @override
  Future<Either<Failure, BookServiceResponse>> bookService(BookServiceRequest req) async {
    try {
      final response = await _restClient.post(url: Apis.bookService ,request: req.toJson());
      return Right(bookServiceResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }
}