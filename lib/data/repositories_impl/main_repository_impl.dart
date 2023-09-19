import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/data_sources/remote/main_remote_data_source.dart';
import 'package:flutter_store_app/data/network/network_info.dart';
import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:flutter_store_app/domain/repositories/main_repository.dart';

import '../../app/exceptions.dart';
import '../../domain/enums/response_status_enum.dart';
import '../../resources/string_manager.dart';

class MainRepositoryImpl extends MainRepository {
  final MainRemoteDataSource _mainRemoteDataSource;
  final NetworkInfo _networkInfo;

  MainRepositoryImpl({
    required MainRemoteDataSource mainRemoteDataSource,
    required NetworkInfo networkInfo,
  })  : _mainRemoteDataSource = mainRemoteDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, HomeDataModel>> getHomeData() async {
    try {
      if (await _networkInfo.isConnected) {
        final response = await _mainRemoteDataSource.getHomeData();
        if (response.status == ResponseStatusEnum.success.statusCode) {
          return Right(response.toDomain());
        } else {
          return Left(
            NetworkFailure(
              message: response.message ?? "",
              code: response.status ?? ResponseStatusEnum.failure.statusCode,
            ),
          );
        }
      } else {
        return Left(NoConnectionFailure(message: StringManager.noConnection));
      }
    } on NetworkException catch (err) {
      return Left(NetworkFailure(
        message: err.message,
        code: ResponseStatusEnum.failure.statusCode,
      ));
    } catch (e) {
      return Left(UnknownFailure(
        message: StringManager.noConnection,
      ));
    }
  }
}
