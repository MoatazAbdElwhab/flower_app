// core/app_data/api/dio_client.dart
import 'package:dio/dio.dart';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../error_handling/dio_error_handler.dart';
import '../../error_handling/exceptions/api_exception.dart';
import '../../logger/app_logger.dart';
import '../../routes/navigator_observer.dart';
import '../../routes/routes.dart';
import '../local_storage/local_storage_client.dart';
import 'api_client.dart';

@Singleton(as: ApiClient)
class DioApiClient implements ApiClient {
  final Dio _dio;
  final LocalStorageClient localStorage;
  final DioErrorHandler errorHandler;
  final GlobalKey<NavigatorState> _appNavigator;

  String? _cachedToken;
  bool _isRetrievingToken = false;

  DioApiClient(this.localStorage, this.errorHandler, this._appNavigator)
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://flower.elevateegy.com/api/v1/',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
        ))
          ..interceptors.add(PrettyDioLogger());

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresToken = true,
  }) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw errorHandler.handle(e);
    }
  }

  @override
  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool requiresToken = true}) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw errorHandler.handle(e);
    }
  }

  @override
  Future<dynamic> put(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool requiresToken = true}) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw errorHandler.handle(e);
    }
  }

  @override
  Future<dynamic> patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      bool requiresToken = true}) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw errorHandler.handle(e);
    }
  }

  @override
  Future<dynamic> delete(String path,
      {Map<String, dynamic>? queryParameters,
      bool requiresToken = true}) async {
    try {
      await checkToken(requiresToken);
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw errorHandler.handle(e);
    }
  }

  Future<void> checkToken(bool requiresToken) async {
    Log.i('requires token : $requiresToken');
    if (!requiresToken) return;

    try {
      if (_cachedToken != null) {
        _dio.options.headers.addAll({'Authorization': 'Bearer $_cachedToken'});
        return;
      }
      if (_isRetrievingToken) {
        while (_isRetrievingToken) {
          await Future.delayed(const Duration(milliseconds: 50));
        }
        if (_cachedToken != null) {
          _dio.options.headers
              .addAll({'Authorization': 'Bearer $_cachedToken'});
          return;
        }
      }

      _isRetrievingToken = true;
      final token = await localStorage.getSecuredData('token');

      _isRetrievingToken = false;

      if (token != null) {
        _cachedToken = token;
        _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
      } else {
        Log.e('throwing ApiException(message: User token is null)');
        throw ApiException(message: 'User token is null');
      }
    } catch (e) {
      _isRetrievingToken = false;

      Log.e(
          'throwing ApiException(message: Failed to retrieve token: ${e.toString()}');
      if (appCurrentRoute != Routes.login && appCurrentRoute != Routes.signup) {
        await localStorage.saveRememberMe(false);
        _appNavigator.currentState
            ?.pushNamedAndRemoveUntil(Routes.login, (route) => false);
      }
      throw ApiException(message: 'Failed to retrieve token: ${e.toString()}');
    }
  }

  void clearTokenCache() {
    _cachedToken = null;
    _dio.options.headers.remove('Authorization');
  }
}
