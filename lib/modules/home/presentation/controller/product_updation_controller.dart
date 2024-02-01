import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/core/storage_service.dart';
import 'package:innovins_assignment/modules/home/data/models/product_list.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/add_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/delete_product_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/edit_prodcut_usecase.dart';
import 'package:innovins_assignment/modules/home/domain/usecases/home_usecases.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductUpdationController extends GetxController {
  ProductUpdationController(
    this.homeUsecase,
    this.addProductUsecase,
    this.editProductUsecase,
    this.deleteProductUsecase,
  );

  final HomeUsecase homeUsecase;
  final AddProductUsecase addProductUsecase;
  final EditProductUsecase editProductUsecase;
  final DeleteProductUsecase deleteProductUsecase;
  RxBool isApiLoading = false.obs;
  RxBool isAddProductApiLoading = false.obs;
  RxList<ProductListModel> productList = <ProductListModel>[].obs;
  DataModel onboardingModel = DataModel();

  RxString userCode = "".obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController moqController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  RxString name = "".obs;
  RxString price = "".obs;
  RxString moq = "".obs;
  RxString discountedPrice = "".obs;

  @override
  void onInit() async {
    await getUserInfo();
    fetchproductList();
    super.onInit();
  }

  Future<void> getUserInfo() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String customerDataString = pref.getString(StorageKeys.keyUserData) ?? "";
    onboardingModel = customerDataString == ""
        ? DataModel()
        : DataModel.fromJson(jsonDecode(customerDataString));
    userCode.value = onboardingModel.userToken ?? "";
  }

  List<String> imagesList = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
  ];

  clearFields() {
    nameController.clear();
    priceController.clear();
    moqController.clear();
    discountController.clear();
  }

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
      } else {}
    }, (r) async {
      productList.value = r;
      for (var element in productList) {
        element.image = imagesList[Random().nextInt(imagesList.length - 1)];
      }
      clearFields();
      isApiLoading(false);
    });
  }

  Future<void> addNewProduct() async {
    isAddProductApiLoading(true);
    final response = await addProductUsecase(
      AddProductUsecaseParams(
        userToken: userCode.value,
        name: name.value,
        moq: moq.value,
        price: price.value,
        discountedPrice: discountedPrice.value,
      ),
    );

    response.fold((l) async {
      isApiLoading(true);
      if (l is NoInternetError) {
      } else if (l is SlowInternetError) {}
    }, (r) async {
      isAddProductApiLoading(false);
      await fetchproductList();
    });
  }

  Future<void> editProduct(String id) async {
    isAddProductApiLoading(true);
    final response = await editProductUsecase(
      EditProductUsecaseParams(
        userToken: userCode.value,
        name: nameController.text,
        moq: moqController.text,
        price: priceController.text,
        discountedPrice: discountController.text,
        id: id,
      ),
    );

    response.fold((l) async {
      isApiLoading(true);
      if (l is NoInternetError) {
      } else if (l is SlowInternetError) {
      } else {}
    }, (r) async {
      isAddProductApiLoading(false);
      await fetchproductList();
    });
  }

  Future<void> deleteProduct(String id) async {
    isAddProductApiLoading(true);
    final response = await deleteProductUsecase(
      DeleteProductUsecaseParams(userToken: userCode.value, id: id),
    );

    response.fold((l) async {
      isApiLoading(true);
      if (l is NoInternetError) {
      } else if (l is SlowInternetError) {
      } else {}
    }, (r) async {
      isAddProductApiLoading(false);
      await fetchproductList();
    });
  }
}
