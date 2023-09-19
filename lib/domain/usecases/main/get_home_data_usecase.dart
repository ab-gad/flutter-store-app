import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';
import 'package:flutter_store_app/domain/models/home_data_model.dart';
import 'package:flutter_store_app/domain/repositories/main_repository.dart';
import 'package:flutter_store_app/domain/usecases/base_usecase.dart';

class GetHomeDataUseCase implements BaseUseCase<void, HomeDataModel> {
  final MainRepository _mainRepository;

  GetHomeDataUseCase({required MainRepository mainRepository})
      : _mainRepository = mainRepository;

  @override
  Future<Either<Failure, HomeDataModel>> call(void input) {
    return _mainRepository.getHomeData();
  }
}
