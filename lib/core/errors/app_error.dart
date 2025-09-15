enum AppErrorType {
  network,
  timeout,
  unauthorized,
  forbidden,
  notFound,
  validation,
  server,
  cancelled,
  unknown,
}

class AppError implements Exception {
  const AppError(this.type, this.message, {this.statusCode, this.cause});

  final AppErrorType type;
  final String message;
  final int? statusCode;
  final Object? cause;

  @override
  String toString() => 'AppError($type, $statusCode): $message';
}
