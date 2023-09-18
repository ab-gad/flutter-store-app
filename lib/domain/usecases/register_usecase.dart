import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/requests/register_request.dart';
import 'package:flutter_store_app/domain/models/login_models.dart';
import 'package:flutter_store_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_store_app/domain/usecases/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterRequest, LoginResponseModel> {
  final AuthenticationRepository _authenticationRepository;

  RegisterUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, LoginResponseModel>> call(RegisterRequest input) {
    return _authenticationRepository.register(input);
  }
}
