import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/core/storage_service.dart';
import 'package:innovins_assignment/modules/home/data/models/product_list.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';

class HomeController extends GetxController {
  HomeController(
    this.homeUsecase,
  );

  final HomeUsecase homeUsecase;
  RxInt bottomNavSelectedIndex = 0.obs;
  RxBool isApiLoading = false.obs;
  RxList<ProductListModel> productList = <ProductListModel>[].obs;
  final pref = GetStorage();
  DataModel onboardingModel = DataModel();
  RxString userCode = "".obs;

  RxList<ProductListModel> cartItems = <ProductListModel>[].obs;

  @override
  void onInit() async {
    getUserInfo();
    // await fetchproductList();
    super.onInit();
  }

  Future<void> getUserInfo() async {
    String customerDataString = pref.read(StorageKeys.keyUserData) ?? "";
    onboardingModel = customerDataString == ""
        ? DataModel()
        : DataModel.fromJson(jsonDecode(customerDataString));
    userCode.value = onboardingModel.userToken ?? "";
    fetchproductList();
  }

  addItemsToCart(int index) {
    log(productList[index].id.toString());
    if (cartItems.isEmpty) {
      productList[index].isCart = true;
      cartItems.add(productList[index]);
      log("1---${cartItems.length.toString()}");
      log("11---${productList[index].isCart.toString()}");
    } else {
      final bool productisinlist =
          cartItems.any((product) => product.id == productList[index].id);
      if (productisinlist) {
        //remove
        productList[index].isCart = false;
        cartItems.remove(productList[index]);
        log("2---${cartItems.length.toString()}");
        log("22---${productList[index].isCart.toString()}");
      } else {
        //add
        productList[index].isCart = true;
        cartItems.add(productList[index]);
        log("3---${cartItems.length.toString()}");
        log("33---${productList[index].isCart.toString()}");
      }
    }
  }

  List<String> imagesList = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
    'assets/images/img3.png',
  ];

  Future<void> fetchproductList() async {
    log(userCode.value);
    isApiLoading(true);
    final response = await homeUsecase(
      HomeUsecaseParams(userToken: userCode.value),
    );

    response.fold((l) async {
      isApiLoading(true);
      if (l is NoInternetError) {
      } else if (l is SlowInternetError) {
      } else {}
    }, (r) async {
      productList.value = r;
      isApiLoading(false);
    });
  }
}
