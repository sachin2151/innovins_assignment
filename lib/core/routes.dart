import 'package:get/get.dart';
import 'package:innovins_assignment/modules/home/presentation/binding/home_binding.dart';
import 'package:innovins_assignment/modules/home/presentation/binding/product_detail_binding.dart';
import 'package:innovins_assignment/modules/home/presentation/binding/product_updation_binding.dart';
import 'package:innovins_assignment/modules/home/presentation/view/home_view.dart';
import 'package:innovins_assignment/modules/home/presentation/view/product_detail_view.dart';
import 'package:innovins_assignment/modules/home/presentation/view/product_updation_view.dart';
import 'package:innovins_assignment/modules/onboarding/presentation/binding/onboarding_binding.dart';
import 'package:innovins_assignment/modules/onboarding/presentation/binding/registration_binding.dart';
import 'package:innovins_assignment/modules/onboarding/presentation/view/onboarding_view.dart';
import 'package:innovins_assignment/modules/onboarding/presentation/view/registration_view.dart';

class OneRoute {
  static const String registrationView = "registration_view";
  static const String onboardingView = "onboarding_view";
  static const String homeView = "home_view";
  static const String productDetailView = "product_detail_view";
  static const String productUpdateView = "product_update_view";

  /// Routes List
  static List<GetPage> routes = [
    GetPage(
      name: '/$registrationView',
      page: () => const RegistrationPage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: '/$onboardingView',
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: '/$homeView',
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/$productDetailView',
      page: () => ProductDetailPage(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: '/$productUpdateView',
      page: () => const ProductUpdationPage(),
      binding: ProductUpdationBinding(),
    ),
  ];
}
