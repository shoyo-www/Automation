import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/book_facility_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_service_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_single_category.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/apis.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/dio/rest_client.dart';
import 'package:hotelautomationapp/domain/Repository/facilities_repository.dart';

class FacilitiesRepositoryImpl implements FacilitiesRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, GetFacilitiesResponse>> getFacilities(String hotelId) async {
    try {
      final response = await _restClient.get(url: Apis.getFacilities + hotelId);
      return Right(getFacilitiesResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

  @override
  Future<Either<Failure, FacilityTypeResponse>> getSingleFacility(String hotelId, String facilityId) async {
    try {
      final response = await _restClient.get(url: "${Apis.getFacilitiesSingle}$hotelId&hotelFacilityId=$facilityId");
      return Right(facilityTypeResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

  @override
  Future<Either<Failure, FacilityTypeResponse>> bookFacility(BookFacilitiesRequest req) async {
    try {
      final response = await _restClient.post(url: Apis.bookFacility,request: req.toJson());
      return Right(facilityTypeResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }
}
