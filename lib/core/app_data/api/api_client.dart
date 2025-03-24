import 'package:dartz/dartz.dart';

import '../../error_handling/exceptions/api_exception.dart';

abstract class ApiClient {
  Future<Either<ApiException, T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters, bool requiresToken = false});

  Future<Either<ApiException, T>> post<T>(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool requiresToken = false});

  Future<Either<ApiException, T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = false,
  });

  Future<Either<ApiException, T>> patch<T>(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool requiresToken = false});
}
