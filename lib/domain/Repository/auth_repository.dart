import 'package:dartz/dartz.dart';
import 'package:hotelautomationapp/core/error/failures.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/login_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/request/otp_request.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/loginResponse.dart';
import 'package:hotelautomationapp/data/datasource/remote/models/response/otp_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginParams);
  Future<Either<Failure, OtpResponse>> verifyOtp(OtpRequest otp);
}
