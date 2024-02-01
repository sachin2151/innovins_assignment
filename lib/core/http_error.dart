import 'package:dio/dio.dart';

abstract class HttpError {
  HttpError({this.message, this.errorCode, this.errorType});
  final String? message;
  final int? errorCode;
  final DioExceptionType? errorType;

  HttpError appErrorType(errorType, message) {
    switch (errorType) {
      case DioExceptionType.connectionTimeout:
        return SlowInternetError();

      case DioExceptionType.receiveTimeout:
        return SlowInternetError();

      case DioExceptionType.sendTimeout:
        return SlowInternetError();

      case DioExceptionType.cancel:
        return CancelError();

      default:
        if (errorCode == 401) {
          return UnAuthorizedError();
        } else if (errorCode == 404) {
          return NotFountError(
              error: errorType, errorCode: errorCode, message: message);
        } else {
          return AppError(errorCode: errorCode, message: message);
        }
    }
  }
}

class AppError extends HttpError {
  AppError({
    super.message,
    super.errorCode,
    DioExceptionType? error,
  }) : super(
          errorType: error,
        );
}

class NoInternetError extends HttpError {
  NoInternetError({super.message, super.errorCode, DioExceptionType? error})
      : super(
          errorType: error,
        );
}

class SlowInternetError extends HttpError {
  SlowInternetError({super.message, super.errorCode, DioExceptionType? error})
      : super(
          errorType: error,
        );
}

class CancelError extends HttpError {
  CancelError({super.message, super.errorCode, DioExceptionType? error})
      : super(
          errorType: error,
        );
}

class UnAuthorizedError extends HttpError {
  UnAuthorizedError({super.message, super.errorCode, DioExceptionType? error})
      : super(
          errorType: error,
        );
}

class NotFountError extends HttpError {
  NotFountError({super.message, super.errorCode, DioExceptionType? error})
      : super(
          errorType: error,
        );
}
