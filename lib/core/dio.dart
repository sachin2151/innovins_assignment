import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

mixin baseDio {
  Future<Dio> getBaseDio() async {
    Map<String, String> headers = {};
    headers['content-type'] = 'application/json';

    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: headers,
    );
    Dio dio = Dio(options);

    dio.interceptors.add(
      LogInterceptor(
        request: kDebugMode,
        requestHeader: kDebugMode,
        requestBody: kDebugMode,
        responseHeader: kDebugMode,
        responseBody: kDebugMode,
        error: kDebugMode,
      ),
    );

    return dio;
  }
}
