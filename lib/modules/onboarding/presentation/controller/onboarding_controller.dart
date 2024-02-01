import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/core/routes.dart';
import 'package:innovins_assignment/core/storage_service.dart';
import 'package:innovins_assignment/modules/onboarding/data/models/onboarding_model.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/login_user_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void onInit() {
    // TODO: implement onInit
    getprefs();
    super.onInit();
  }

  getprefs() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String customerDataString = pref.getString(StorageKeys.keyUserData) ?? "";

    DataModel onboardingModel = customerDataString == ""
        ? DataModel()
        : DataModel.fromJson(jsonDecode(customerDataString));
    await Future.delayed(const Duration(seconds: 2));
    log(onboardingModel.userToken ?? "");
    if (onboardingModel.userToken?.isEmpty ??
        false || onboardingModel.userToken == null) {
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
      } else {
        Get.snackbar("Sorry", "User not registered",
            colorText: Colors.red,
            messageText: const Text(
              "User not Registered",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.red),
            ));
      }
    }, (r) async {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      log(r.data?.userToken ?? "");
      await pref.setString(
        StorageKeys.keyUserData,
        jsonEncode(r.data),
      );
      isApiLoading(false);
      Get.offAllNamed(OneRoute.productUpdateView);
    });
  }
}
