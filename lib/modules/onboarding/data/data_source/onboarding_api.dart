import 'package:dio/dio.dart';
import 'package:innovins_assignment/core/dio.dart';
import 'package:innovins_assignment/core/urls.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/login_user_usecase.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/register_user_usecase.dart';

abstract class OnboardingApi {
  OnboardingApi();

  Future<OnboardingModel> loginUser(
    LoginUsecaseParams params,
  );

  Future<OnboardingModel> registerUser(
    RegisterUsecaseParams params,
  );
}

class OnboardingApiImpl with baseDio implements OnboardingApi {
  OnboardingApiImpl() : super();

  @override
  Future<OnboardingModel> loginUser(LoginUsecaseParams params) async {
    Dio dio = await getBaseDio();
    final response = await dio.post(
      Urls.loginApi,
      data: FormData.fromMap(params.toJson()),
    );
    OnboardingModel res = OnboardingModel.fromJson(response.data);

    return res;
  }

  @override
  Future<OnboardingModel> registerUser(RegisterUsecaseParams params) async {
    Dio dio = await getBaseDio();
    final response = await dio.post(
      Urls.registerApi,
      data: FormData.fromMap(params.toJson()),
    );
    OnboardingModel res = OnboardingModel.fromJson(response.data);

    return res;
  }
}
