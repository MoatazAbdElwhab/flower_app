// core/error_handling/exceptions/network_exception.dart
import 'app_exception.dart';

class NetworkException extends AppException {
  NetworkException(super.message);
  @override
  String toString() {
    return message;
  }
}
