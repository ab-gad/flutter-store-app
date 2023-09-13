import 'package:dartz/dartz.dart';
import 'package:flutter_store_app/app/failures.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<Failure, Output>> call(Input input);
}
