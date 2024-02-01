import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/core/routes.dart';
import 'package:innovins_assignment/core/storage_service.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/login_user_usecase.dart';

class OnboardingController extends GetxController {
  OnboardingController(
    this.loginUsecase,
  );

  final LoginUsecase loginUsecase;
  String email = "";
  String password = "";
  RxBool isApiLoading = false.obs;
  RxBool loading = true.obs;

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String emailErrorText = "";
  final pref = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    getprefs();
    super.onInit();
  }

  getprefs() async {
    final pref = GetStorage();
    String customerDataString = pref.read(StorageKeys.keyUserData) ?? "";

    DataModel onboardingModel = customerDataString == ""
        ? DataModel()
        : DataModel.fromJson(jsonDecode(customerDataString));
    log(customerDataString);
    log(onboardingModel.userToken ?? "");
    await Future.delayed(const Duration(seconds: 1));
    if (onboardingModel.userToken?.isEmpty ?? false) {
      loading(false);
    } else {
      Get.offAllNamed(OneRoute.productUpdateView);
    }
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailErrorText = 'Email is required';
    } else if (!isEmailValid(value)) {
      emailErrorText = 'Enter a valid email address';
    } else {
      emailErrorText = "";
    }
  }

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  // void submitForm() {
  //   if (formKey.currentState!.validate()) {
  //     print('Email: ${emailController.text}');
  //   }
  // }

  /// Request for an OTP API
  Future<void> loginUser(BuildContext context) async {
    log("$email $password");
    isApiLoading(true);
    final response = await loginUsecase(
      LoginUsecaseParams(
        email: email,
        password: password,
      ),
    );

    response.fold((l) async {
      isApiLoading(false);
      if (l is NoInternetError) {
      } else if (l is SlowInternetError) {
      } else {}
    }, (r) async {
      isApiLoading(false);
      log(r.data?.userToken ?? "");
      await pref.write(
        StorageKeys.keyUserData,
        jsonEncode(r.data),
      );
      Get.toNamed(OneRoute.productUpdateView);
    });
  }
}
