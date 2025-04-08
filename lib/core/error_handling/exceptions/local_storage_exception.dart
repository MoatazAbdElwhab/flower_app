// core/error_handling/exceptions/local_storage_exception.dart
import 'package:flower_app/core/error_handling/exceptions/app_exception.dart';

class LocalStorageException extends AppException {
  LocalStorageException(super.message);
}