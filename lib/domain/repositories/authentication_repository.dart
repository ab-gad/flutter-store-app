import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/requests/fogot_password_request.dart';
import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/domain/models/forgot_password_response_moder.dart';
import 'package:flutter_store_app/domain/models/login_models.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, LoginResponseModel>> login(LoginRequest loginData);
  Future<Either<Failure, ForgotPasswordResponseModel>> forgotPassword(
      ForgotPasswordRequest forgotPasswordData);
}
