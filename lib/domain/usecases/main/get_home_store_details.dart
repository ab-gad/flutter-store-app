import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:flutter_store_app/domain/repositories/main_repository.dart';
import 'package:flutter_store_app/domain/usecases/base_usecase.dart';

class GetHomeStoreDetailsUseCase
    implements BaseUseCase<int, HomeStoreItemDetailsModel> {
  final MainRepository _mainRepository;

  GetHomeStoreDetailsUseCase({required MainRepository mainRepository})
      : _mainRepository = mainRepository;

  @override
  Future<Either<Failure, HomeStoreItemDetailsModel>> call(int storeId) {
    return _mainRepository.getHomeStoreDetails(storeId);
  }
}
