import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/data/data_sources/remote/main_remote_data_source.dart';
import 'package:flutter_store_app/data/network/network_info.dart';
import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:flutter_store_app/domain/repositories/main_repository.dart';

import '../../app/exceptions.dart';
import '../../domain/enums/response_status_enum.dart';
import '../../generated/locale_keys.g.dart';
import '../data_sources/local/main_local_data_source.dart';

class MainRepositoryImpl extends MainRepository {
  final MainRemoteDataSource _mainRemoteDataSource;
  final MainLocalDataSource _mainLocalDataSource;
  final NetworkInfo _networkInfo;

  MainRepositoryImpl({
    required MainRemoteDataSource mainRemoteDataSource,
    required MainLocalDataSource mainLocalDataSource,
    required NetworkInfo networkInfo,
  })  : _mainRemoteDataSource = mainRemoteDataSource,
        _mainLocalDataSource = mainLocalDataSource,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, HomeDataModel>> getHomeData() async {
    // Try to get data from cash first (if there is valid data exist)
    // If no valid data, then fetch the data from remote
    try {
      final validCashedData = await _mainLocalDataSource.getHomeData();
      return Right(validCashedData.toDomain());
    } on CashException {
      try {
        if (await _networkInfo.isConnected) {
          final response = await _mainRemoteDataSource.getHomeData();
          if (response.status == ResponseStatusEnum.success.statusCode) {
            _mainLocalDataSource.setHomeData(response);
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
          return Left(
              NoConnectionFailure(message: LocaleKeys.noConnection.tr()));
        }
      } on NetworkException catch (err) {
        return Left(NetworkFailure(
          message: err.message,
          code: ResponseStatusEnum.failure.statusCode,
        ));
      } catch (e) {
        return Left(UnknownFailure(
          message: LocaleKeys.noConnection.tr(),
        ));
      }
    }
  }

  @override
  Future<Either<Failure, HomeStoreItemDetailsModel>> getHomeStoreDetails(
      int storeId) async {
    // Try to get data from cash first (if there is valid data exist)
    // If no valid data, then fetch the data from remote
    try {
      final validCashedData =
          await _mainLocalDataSource.getHomeStoreDetails(storeId);
      return Right(validCashedData.toDomain());
    } on CashException {
      try {
        if (await _networkInfo.isConnected) {
          final response =
              await _mainRemoteDataSource.getHomeStoreDetails(storeId);
          if (response.status == ResponseStatusEnum.success.statusCode) {
            _mainLocalDataSource.setHomeStoreDetails(storeId, response);
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
          return Left(
              NoConnectionFailure(message: LocaleKeys.noConnection.tr()));
        }
      } on NetworkException catch (err) {
        return Left(NetworkFailure(
          message: err.message,
          code: ResponseStatusEnum.failure.statusCode,
        ));
      } catch (e) {
        return Left(UnknownFailure(
          message: LocaleKeys.noConnection.tr(),
        ));
      }
    }
  }
}
