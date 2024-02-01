import 'package:get/get.dart';
import 'package:innovins_assignment/modules/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/login_user_usecase.dart';
import 'package:innovins_assignment/modules/onboarding/presentation/controller/onboarding_controller.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginUsecase(Get.find<OnboardingRepositoryImpl>()),
    );
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(
        Get.find<LoginUsecase>(),
      ),
    );
  }
}
