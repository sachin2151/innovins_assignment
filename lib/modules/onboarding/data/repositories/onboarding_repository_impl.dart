import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/core/network_info.dart';
import 'package:innovins_assignment/modules/onboarding/data/data_source/onboarding_api.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:innovins_assignment/modules/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/login_user_usecase.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/register_user_usecase.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this.onboardingApi, this.networkInfo);

  final OnboardingApi onboardingApi;
  final NetworkInfo networkInfo;

  @override
  Future<Either<HttpError, OnboardingModel>> loginUser(
    LoginUsecaseParams params,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        OnboardingModel response = await onboardingApi.loginUser(params);
        return Right(response);
      } on DioException catch (e) {
        return Left(
          AppError(errorCode: e.response?.statusCode)
              .appErrorType(e.type, e.message),
        );
      }
    } else {
      return Left(NoInternetError());
    }
  }

  @override
  Future<Either<HttpError, OnboardingModel>> registerUser(
    RegisterUsecaseParams params,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        OnboardingModel response = await onboardingApi.registerUser(params);
        return Right(response);
      } on DioException catch (e) {
        return Left(
          AppError(errorCode: e.response?.statusCode)
              .appErrorType(e.type, e.message),
        );
      }
    } else {
      return Left(NoInternetError());
    }
  }
}
