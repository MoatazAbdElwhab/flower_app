// core/error_handling/exceptions/app_exception.dart
abstract class AppException implements Exception {
  final String message;
  AppException(this.message,);
}
