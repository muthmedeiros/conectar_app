import 'package:dio/dio.dart';

import 'app_error.dart';

class ErrorMapper {
  static AppError fromDio(DioException e) {
    final sc = e.response?.statusCode;

    // Type-based
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return AppError(
          AppErrorType.network,
          'No internet connection.',
          statusCode: sc,
          cause: e,
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return AppError(
          AppErrorType.timeout,
          'Request timed out.',
          statusCode: sc,
          cause: e,
        );
      case DioExceptionType.cancel:
        return AppError(
          AppErrorType.cancelled,
          'Request cancelled.',
          statusCode: sc,
          cause: e,
        );
      case DioExceptionType.badResponse:
        break;
      case DioExceptionType.badCertificate:
        return AppError(
          AppErrorType.network,
          'Certificate error.',
          statusCode: sc,
          cause: e,
        );
    }

    // Status-based
    if (sc == 401) {
      return AppError(
        AppErrorType.unauthorized,
        'You need to login again.',
        statusCode: sc,
        cause: e,
      );
    }

    if (sc == 403) {
      return AppError(
        AppErrorType.forbidden,
        'You don’t have permission for this action.',
        statusCode: sc,
        cause: e,
      );
    }

    if (sc == 404) {
      return AppError(
        AppErrorType.notFound,
        'Resource not found.',
        statusCode: sc,
        cause: e,
      );
    }

    if (sc != null && sc >= 400 && sc < 500) {
      final msg =
          _extractMessage(e.response?.data) ?? 'Request validation failed.';

      return AppError(AppErrorType.validation, msg, statusCode: sc, cause: e);
    }

    if (sc != null && sc >= 500) {
      return AppError(
        AppErrorType.server,
        'Server error. Try again later.',
        statusCode: sc,
        cause: e,
      );
    }

    return AppError(
      AppErrorType.unknown,
      'Unexpected error.',
      statusCode: sc,
      cause: e,
    );
  }

  static String? _extractMessage(dynamic data) {
    if (data is Map && data['message'] is String) {
      return data['message'] as String;
    }

    return null;
  }
}
