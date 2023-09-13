import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/domain/models/login_models.dart';
import 'package:flutter_store_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_store_app/domain/usecases/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginRequest, LoginResponseModel> {
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, LoginResponseModel>> call(LoginRequest input) {
    return _authenticationRepository.login(input);
  }
}
