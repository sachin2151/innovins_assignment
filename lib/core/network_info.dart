import 'dart:io';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();

  InternetConnectionChecker internetChecker =
      InternetConnectionChecker.createInstance(
    checkTimeout: const Duration(seconds: 10), // Custom check timeout
    checkInterval: const Duration(seconds: 1), // Custom check interval
    addresses: [
      AddressCheckOptions(
        address: InternetAddress(
          '8.8.4.4', // Google
          type: InternetAddressType.IPv4,
        ),
      ),
      AddressCheckOptions(
        address: InternetAddress(
          '2001:4860:4860::8888', // Google
          type: InternetAddressType.IPv6,
        ),
      ),
    ],
  );

  @override
  Future<bool> get isConnected async {
    bool hasConnection = await internetChecker.hasConnection.timeout(
      const Duration(seconds: 10),
      onTimeout: () => false,
    );

    if (!hasConnection) {
      // if (Get.currentRoute == OneRoute.noInternetView ||
      //     Get.currentRoute == OneRoute.slowInternetView) {
      //   return false;
      // }
      await Future.delayed(const Duration(seconds: 5));
      return false;
    } else {
      return true;
    }
  }
}
