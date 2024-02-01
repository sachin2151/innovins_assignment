import 'package:dartz/dartz.dart';
import 'package:innovins_assignment/core/http_error.dart';

abstract class BaseUsecase<Type, Params> {
  Future<Either<HttpError, Type>> call(Params params);
}

abstract class Params {}
