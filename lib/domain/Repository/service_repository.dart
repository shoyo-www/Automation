import 'package:dartz/dartz.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/book_service_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/book_service_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_facility_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/get_pending_request.dart';

abstract class ServiceRepository {
  Future<Either<Failure, GetServiceResponse>> getService(String hotelId);
  Future<Either<Failure, GetPendingRequestResponse>> getPendingRequest(String hotelId);
  Future<Either<Failure, BookServiceResponse>> bookService(BookServiceRequest req);
}