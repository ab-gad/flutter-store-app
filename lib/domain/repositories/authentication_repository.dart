import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/domain/models/login_models.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, LoginResponseModel>> login(LoginRequest loginData);
}
