import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';

import '../models/home_data_model.dart';

abstract class MainRepository {
  Future<Either<Failure, HomeDataModel>> getHomeData();
}
