import 'package:get/get.dart';
import 'package:innovins_assignment/modules/home/data/repositories/home_repository_impl.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';
import 'package:innovins_assignment/modules/home/presentation/controller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeUsecase(Get.find<HomeRepositoryImpl>()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<HomeUsecase>(),
      ),
    );
  }
}
