import 'package:get/get.dart';
import 'package:innovins_assignment/core/network_info.dart';
import 'package:innovins_assignment/modules/home/data/data_source/home_view_api.dart';
import 'package:innovins_assignment/modules/home/data/repositories/home_repository_impl.dart';
import 'package:innovins_assignment/modules/onboarding/data/data_source/onboarding_api.dart';
import 'package:innovins_assignment/modules/onboarding/data/repositories/onboarding_repository_impl.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    /// Connectivity
    Get.lazyPut<NetworkInfo>(
      () => NetworkInfoImpl(),
      fenix: true,
    );

    /// Onbaording API
    Get.lazyPut<OnboardingApi>(
      () => OnboardingApiImpl(),
      fenix: true,
    );

    Get.lazyPut<OnboardingRepositoryImpl>(
      () => OnboardingRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<HomeApi>(
      () => HomeApiImpl(),
      fenix: true,
    );

    Get.lazyPut<HomeRepositoryImpl>(
      () => HomeRepositoryImpl(
        Get.find(),
        Get.find(),
      ),
      fenix: true,
    );
  }
}
