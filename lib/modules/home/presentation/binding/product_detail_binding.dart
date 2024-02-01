import 'package:get/get.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';
import 'package:innovins_assignment/modules/home/presentation/controller/home_controller.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<HomeUsecase>(),
      ),
    );
  }
}
