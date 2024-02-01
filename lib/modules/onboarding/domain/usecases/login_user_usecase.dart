import 'package:dartz/dartz.dart';
import 'package:innovins_assignment/core/base_class.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:innovins_assignment/modules/onboarding/domain/repositories/onboarding_repository.dart';

class LoginUsecase extends BaseUsecase<OnboardingModel, LoginUsecaseParams> {
  LoginUsecase(this.onboardingRepository);

  final OnboardingRepository onboardingRepository;

  @override
  Future<Either<HttpError, OnboardingModel>> call(params) async {
    return await onboardingRepository.loginUser(params);
  }
}

class LoginUsecaseParams {
  LoginUsecaseParams({
    this.email,
    this.password,
  });

  LoginUsecaseParams.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }
  String? email;
  String? password;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
