// features/auth/data/repository/auth_repo_impl.dart
import 'package:either_dart/either.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/app_data/api/graphql/graphql_provider.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../../../core/error_handling/exceptions/local_storage_exception.dart';
import '../../../../core/error_handling/exceptions/network_exception.dart';
import '../../domain/entities/auth_response_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../datasource/local_data_source/auth_local_data_source_contract.dart';
import '../datasource/remote_data_source/auth_remote_data_source_contract.dart';
import '../model/signup_request_model.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract _remoteDataSource;
  final AuthLocalDataSourceContract _localDataSource;
  final AppGraphQLProvider _graphQLProvider;
  final Logger _logger;

  AuthRepoImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._graphQLProvider,
    this._logger,
  );

  @override
  Future<Either<Exception, AuthResponseEntity>> signIn(
      String email, String password, bool rememberMe) async {
    try {
      final response = await _remoteDataSource.signIn(email, password);

      if (response.isLeft) {
        return Left(response.left);
      }

      final loginResponse = response.right;

      // Save token if remember me is enabled
      if (rememberMe && loginResponse.token != null) {
        await _localDataSource.cacheToken(loginResponse.token!);
        await _localDataSource.cacheIsGuest(false);
      }

      // Update GraphQL client with new token
      await _graphQLProvider.updateToken();

      return Right(
        AuthResponseEntity(
          token: loginResponse.token,
          message: loginResponse.message,
          user: loginResponse.user != null
              ? UserEntity.toEntity(loginResponse.user!)
              : null,
        ),
      );
    } on ApiException catch (e) {
      _logger.e('API error: ${e.message}');
      return Left(e);
    } on NetworkException catch (e) {
      _logger.e('Network error: ${e.message}');
      return Left(e);
    } on LocalStorageException catch (e) {
      _logger.e('Local storage error: ${e.message}');
      return Left(e);
    } catch (e) {
      _logger.e('Unknown error: $e');
      return Left(Exception('Unknown error occurred'));
    }
  }

  @override
  Future<Either<Exception, AuthResponseEntity>> signInAsGuest() async {
    try {
      // Call remote data source for guest login
      final response = await _remoteDataSource.signInAsGuest();

      if (response.isLeft) {
        return Left(response.left);
      }

      final guestLoginResponse = response.right;

      // Always save guest token
      if (guestLoginResponse.token != null) {
        await _localDataSource.cacheToken(guestLoginResponse.token!);
      }

      // Set guest flag
      await _localDataSource.cacheIsGuest(true);

      // Update GraphQL client with new guest token
      await _graphQLProvider.updateToken();

      return Right(
        AuthResponseEntity(
          token: guestLoginResponse.token,
          message: guestLoginResponse.message,
          user: guestLoginResponse.user != null
              ? UserEntity.toEntity(guestLoginResponse.user!)
              : null,
          isGuest: true,
        ),
      );
    } on ApiException catch (e) {
      _logger.e('API error during guest login: ${e.message}');
      return Left(e);
    } on NetworkException catch (e) {
      _logger.e('Network error during guest login: ${e.message}');
      return Left(e);
    } on LocalStorageException catch (e) {
      _logger.e('Local storage error during guest login: ${e.message}');
      return Left(e);
    } catch (e) {
      _logger.e('Unknown error during guest login: $e');
      return Left(Exception('Unknown error occurred during guest login'));
    }
  }

  @override
  Future<Either<ApiException, void>> signup(SignUpRequestModel request) async {
    try {
      await _remoteDataSource.signup(request);
      return const Right(null);
    } catch (e) {
      if (e is ApiException) {
        return Left(e);
      }
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> forgetPassword(String email) async {
    try {
      await _remoteDataSource.forgetPassword(email);
      return const Right(null);
    } catch (e) {
      if (e is ApiException) {
        return Left(e);
      }
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> verifyResetCode(String resetCode) async {
    try {
      await _remoteDataSource.verifyResetCode(resetCode);
      return const Right(null);
    } catch (e) {
      if (e is ApiException) {
        return Left(e);
      }
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> resetPassword(
      String email, String newPassword) async {
    try {
      await _remoteDataSource.resetPassword(email, newPassword);
      return const Right(null);
    } catch (e) {
      if (e is ApiException) {
        return Left(e);
      }
      return Left(ApiException(message: e.toString()));
    }
  }
}
