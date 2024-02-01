import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovins_assignment/core/routes.dart';
import 'package:innovins_assignment/modules/home/presentation/controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends GetView<HomeController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.person_2_rounded,
            size: 80,
          ),
          Text(
            "Name : ${controller.onboardingModel.name}",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          Text(
            "Email : ${controller.onboardingModel.email}",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          Text(
            "Phone : ${controller.onboardingModel.mobile}",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
          const SizedBox(
            height: 40,
          ),
          TextButton(
              onPressed: () async {
                final SharedPreferences pref =
                    await SharedPreferences.getInstance();
                pref.clear().then((value) {
                  Get.offAllNamed(OneRoute.onboardingView);
                });
              },
              child: const Text(
                "Log Out",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ))
        ],
      ),
    )));
  }
}
