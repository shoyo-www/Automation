import 'package:dartz/dartz.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/book_facility_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_service_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_single_category.dart';

abstract class FacilitiesRepository {
  Future<Either<Failure, GetFacilitiesResponse>> getFacilities(String hotelId);
  Future<Either<Failure, FacilityTypeResponse>> getSingleFacility(String hotelId,String facilityId);
  Future<Either<Failure, FacilityTypeResponse>> bookFacility(BookFacilitiesRequest req);
}
