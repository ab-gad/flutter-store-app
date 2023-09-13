import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/exceptions.dart';
import 'package:flutter_store_app/app/extensions.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/data_sources/authentication_remote_data_source.dart';
import 'package:flutter_store_app/data/mappers/login_mappers.dart';
import 'package:flutter_store_app/data/network/network_info.dart';
import 'package:flutter_store_app/data/requests/login_request.dart';
import 'package:flutter_store_app/domain/enums/response_status_enum.dart';
import 'package:flutter_store_app/domain/models/login_models.dart';
import 'package:flutter_store_app/domain/repositories/authentication_repository.dart';
import 'package:flutter_store_app/resources/string_manager.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;
  final NetworkInfo _netWorkInfo;

  AuthenticationRepositoryImpl(this._remoteDataSource, this._netWorkInfo);

  @override
  Future<Either<Failure, LoginResponseModel>> login(
    LoginRequest loginData,
  ) async {
    try {
      if (await _netWorkInfo.isConnected) {
        final response = await _remoteDataSource.login(loginData);
        if (response.status == ResponseStatusEnum.success.statusCode) {
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
}
