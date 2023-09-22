import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/exceptions.dart';
import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/data_sources/local/main_local_data_source.dart';
import 'package:flutter_store_app/data/data_sources/remote/authentication_remote_data_source.dart';
import 'package:flutter_store_app/data/mappers/login_mappers.dart';
import 'package:flutter_store_app/data/network/network_info.dart';
import 'package:flutter_store_app/data/requests/fogot_password_request.dart';
import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/data/requests/register_request.dart';
import 'package:flutter_store_app/domain/enums/response_status_enum.dart';
import 'package:flutter_store_app/domain/models/forgot_password_response_moder.dart';
import 'package:flutter_store_app/domain/models/login_models.dart';
import 'package:flutter_store_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_store_app/resources/string_manager.dart';

import '../../app/app_prefs_repository.dart';
import '../../app/service_locator.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;
  final NetworkInfo _netWorkInfo;
  final AppPrefsRepository _appPrefs;
  final _mainLocalDataSource = sl<MainLocalDataSource>();

  AuthenticationRepositoryImpl(
    this._remoteDataSource,
    this._netWorkInfo,
    this._appPrefs,
  );

  @override
  Future<Either<Failure, LoginResponseModel>> login(
    LoginRequest loginData,
  ) async {
    try {
      if (await _netWorkInfo.isConnected) {
        final response = await _remoteDataSource.login(loginData);
        if (response.status == ResponseStatusEnum.success.statusCode) {
          _appPrefs.setIsUserLoggedIn(true);
          return Right(response.toDomain());
        } else {
          return Left(
            NetworkFailure(
                message: response.message.orEmpty(),
                code: response.status.orZero()),
          );
        }
      } else {
        return Left(NoConnectionFailure(message: StringManager.noConnection));
      }
    } on NetworkException catch (err) {
      return Left(NetworkFailure(message: err.message, code: 1));
    } catch (e) {
      return Left(UnknownFailure(message: StringManager.noConnection));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordResponseModel>> forgotPassword(
      ForgotPasswordRequest forgotPasswordData) async {
    try {
      if (await _netWorkInfo.isConnected) {
        final response =
            await _remoteDataSource.forgotPassword(forgotPasswordData);
        if (response.status == ResponseStatusEnum.success.statusCode) {
          return Right(response.toDomain());
        } else {
          return Left(
            NetworkFailure(
              message: response.message.orEmpty(),
              code: response.status.orZero(),
            ),
          );
        }
      } else {
        return Left(NoConnectionFailure(message: StringManager.noConnection));
      }
    } on NetworkException catch (err) {
      return Left(NetworkFailure(message: err.message, code: 1));
    } catch (e) {
      return Left(UnknownFailure(message: StringManager.noConnection));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> register(
      RegisterRequest registerData) async {
    try {
      if (await _netWorkInfo.isConnected) {
        final response = await _remoteDataSource.register(registerData);
        if (response.status == ResponseStatusEnum.success.statusCode) {
          _appPrefs.setIsUserLoggedIn(true);
          return Right(response.toDomain());
        } else {
          return Left(
            NetworkFailure(
                message: response.message.orEmpty(),
                code: response.status.orZero()),
          );
        }
      } else {
        return Left(NoConnectionFailure(message: StringManager.noConnection));
      }
    } on NetworkException catch (err) {
      return Left(NetworkFailure(message: err.message, code: 1));
    } catch (e) {
      return Left(UnknownFailure(message: StringManager.noConnection));
    }
  }

  @override
  Future<bool> logout() async {
    return (await _appPrefs.setIsUserLoggedIn(false)).fold(
      (failure) {
        return Future.value(false);
      },
      (success) {
        try {
          _mainLocalDataSource.clear();
          return Future.value(true);
        } catch (e) {
          return Future.value(false);
        }
      },
    );
  }
}
