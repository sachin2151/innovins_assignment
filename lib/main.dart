import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:innovins_assignment/core/initial_bindings.dart';
import 'package:innovins_assignment/core/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      title: "Innovium",
      initialBinding: InitialBinding(),
      initialRoute: OneRoute.onboardingView,
      getPages: OneRoute.routes,
    );
  }
}
