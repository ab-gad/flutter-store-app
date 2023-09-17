import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/requests/fogot_password_request.dart';
import 'package:flutter_store_app/domain/models/forgot_password_response_moder.dart';
import 'package:flutter_store_app/domain/usecases/base_usecase.dart';

import '../repositories/authentication_repository.dart';

class ForgotPasswordUseCase
    implements BaseUseCase<ForgotPasswordRequest, ForgotPasswordResponseModel> {
  final AuthenticationRepository _authenticationRepository;

  ForgotPasswordUseCase(this._authenticationRepository);

  @override
  Future<Either<Failure, ForgotPasswordResponseModel>> call(
      ForgotPasswordRequest forgotPasswordData) {
    return _authenticationRepository.forgotPassword(forgotPasswordData);
  }
}
