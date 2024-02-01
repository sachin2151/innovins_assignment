import 'package:get/get.dart';
import 'package:innovins_assignment/modules/home/data/repositories/home_repository_impl.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/add_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/delete_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/edit_prodcut_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';
import 'package:innovins_assignment/modules/home/presentation/controller/product_updation_controller.dart';

class ProductUpdationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeUsecase(Get.find<HomeRepositoryImpl>()),
    );
    Get.lazyPut(
      () => AddProductUsecase(Get.find<HomeRepositoryImpl>()),
    );
    Get.lazyPut(
      () => EditProductUsecase(Get.find<HomeRepositoryImpl>()),
    );
    Get.lazyPut(
      () => DeleteProductUsecase(Get.find<HomeRepositoryImpl>()),
    );
    Get.lazyPut<ProductUpdationController>(
      () => ProductUpdationController(
        Get.find<HomeUsecase>(),
        Get.find<AddProductUsecase>(),
        Get.find<EditProductUsecase>(),
        Get.find<DeleteProductUsecase>(),
      ),
    );
  }
}
