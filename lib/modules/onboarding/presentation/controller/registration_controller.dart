import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:innovins_assignment/core/http_error.dart';
import 'package:innovins_assignment/core/routes.dart';
import 'package:innovins_assignment/core/storage_service.dart';
import 'package:innovins_assignment/modules/onboarding/domain/usecases/register_user_usecase.dart';

class RegistrationController extends GetxController {
  RegistrationController(
    this.registerUsecase,
  );

  final RegisterUsecase registerUsecase;
  String email = "";
  String password = "";
  String name = "";
  String number = "";
  RxBool isApiLoading = false.obs;
  final pref = GetStorage();

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String emailErrorText = "";

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
  Future<void> registerUser(BuildContext context) async {
    isApiLoading(true);
    final response = await registerUsecase(
      RegisterUsecaseParams(
        email: email,
        password: password,
        name: name,
        number: number,
      ),
    );

    response.fold((l) async {
      isApiLoading(false);
      if (l is NoInternetError) {
      } else if (l is SlowInternetError) {
      } else {}
    }, (r) async {
      await pref.write(
        StorageKeys.keyUserData,
        jsonEncode(r.data),
      );
      Get.offAllNamed(OneRoute.productUpdateView);
      isApiLoading(false);
    });
  }
}
