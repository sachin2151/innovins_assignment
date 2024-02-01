import 'package:dartz/dartz.dart';
import 'package:innovins_assignment/core/base_class.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:innovins_assignment/modules/onboarding/domain/repositories/onboarding_repository.dart';

class RegisterUsecase
    extends BaseUsecase<OnboardingModel, RegisterUsecaseParams> {
  RegisterUsecase(this.onboardingRepository);

  final OnboardingRepository onboardingRepository;

  @override
  Future<Either<HttpError, OnboardingModel>> call(params) async {
    return await onboardingRepository.registerUser(params);
  }
}

class RegisterUsecaseParams {
  RegisterUsecaseParams({
    this.email,
    this.password,
    this.number,
    this.name,
  });

  RegisterUsecaseParams.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    number = json['mobile'];
  }
  String? email;
  String? password;
  String? number;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['mobile'] = number;
    data['name'] = name;
    return data;
  }
}
