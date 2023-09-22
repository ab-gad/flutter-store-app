import 'package:flutter_store_app/domain/repositories/authentication_repository.dart';

class LogoutUseCase {
  final AuthenticationRepository _authenticationRepository;

  LogoutUseCase({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  Future<bool> call() {
    return _authenticationRepository.logout();
  }
}
