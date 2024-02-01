import 'package:get/get.dart';
import 'package:innovins_assignment/modules/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/register_user_usecase.dart';
import 'package:innovins_assignment/modules/onboarding/presentation/controller/registration_controller.dart';

class RegistrationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterUsecase(Get.find<OnboardingRepositoryImpl>()),
    );
    Get.lazyPut<RegistrationController>(
      () => RegistrationController(
        Get.find<RegisterUsecase>(),
      ),
    );
  }
}
