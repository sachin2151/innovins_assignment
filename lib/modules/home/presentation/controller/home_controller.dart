import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/core/storage_service.dart';
import 'package:innovins_assignment/modules/home/data/models/product_list.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  HomeController(
    this.homeUsecase,
  );

  final HomeUsecase homeUsecase;
  RxInt bottomNavSelectedIndex = 0.obs;
  RxBool isApiLoading = false.obs;
  RxList<ProductListModel> productList = <ProductListModel>[].obs;
  RxList<ProductListModel> displayList = <ProductListModel>[].obs;

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
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String customerDataString = pref.getString(StorageKeys.keyUserData) ?? "";
    onboardingModel = customerDataString == ""
        ? DataModel()
        : DataModel.fromJson(jsonDecode(customerDataString));
    userCode.value = onboardingModel.userToken ?? "";
    fetchproductList();
  }

  addItemsToCart(int index) {
    if (cartItems.isEmpty) {
      productList[index].isCart = true;
      cartItems.add(productList[index]);
    } else {
      final bool productisinlist =
          cartItems.any((product) => product.id == productList[index].id);
      if (productisinlist) {
        //remove
        productList[index].isCart = false;
        cartItems.remove(productList[index]);
      } else {
        //add
        productList[index].isCart = true;
        cartItems.add(productList[index]);
      }
    }
    update();
  }

  List<String> imagesList = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
  ];

  Future<void> fetchproductList() async {
    isApiLoading(true);
    final response = await homeUsecase(
      HomeUsecaseParams(userToken: userCode.value),
    );

    response.fold((l) async {
      isApiLoading(false);
      if (l is NoInternetError) {
      } else if (l is SlowInternetError) {
      } else if (l is NotFountError) {
        productList.value = [];
        displayList.value = [];
      } else {}
    }, (r) async {
      productList.value = r;
      displayList.value = r;
      for (var element in productList) {
        element.image = imagesList[Random().nextInt(imagesList.length - 1)];
      }
      displayList.value = productList;
      isApiLoading(false);
    });
  }
}
