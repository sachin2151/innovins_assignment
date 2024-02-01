import 'package:dartz/dartz.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/login_user_usecase.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/register_user_usecase.dart';

abstract class OnboardingRepository {
  Future<Either<HttpError, OnboardingModel>> loginUser(
    LoginUsecaseParams params,
  );

  Future<Either<HttpError, OnboardingModel>> registerUser(
    RegisterUsecaseParams params,
  );
}
