import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:hotelautomationapp/core/error/exceptions.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/login_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/otp_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/loginResponse.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/apis.dart';
import 'package:hotelautomationapp/data/datasource/remote/services/dio/rest_client.dart';
import 'package:hotelautomationapp/domain/Repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final _restClient = Get.find<RestClient>();

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginParams) async {
    try {
      final response = await _restClient.post(
          url: Apis.login, request: loginParams.toJson());
      return Right(loginResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }

  @override
  Future<Either<Failure, OtpResponse>> verifyOtp(OtpRequest otp) async {
    try {
      final response = await _restClient.post(
          url: Apis.verifyOtp, request: otp.toJson());
      return Right(otpResponseFromJson(response));
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message,e.type));
    }
  }
}