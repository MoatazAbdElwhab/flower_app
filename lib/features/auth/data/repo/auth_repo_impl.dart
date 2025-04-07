import 'dart:ffi';

import 'package:either_dart/src/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/data/model/signup_request_model.dart';
import 'package:flower_app/core/error_handling/exceptions/local_storage_exception.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:flower_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
import 'package:flower_app/features/auth/data/model/response/sign_in_response/sign_in_response.dart';
import 'package:flower_app/features/auth/domain/entities/auth_response_entity.dart';
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthLocalDataSourceContract authLocalDataSource;
  final AuthRemoteDataSourceContract authRemoteDataSource;

  AuthRepoImpl(this.authLocalDataSource, this.authRemoteDataSource);

//---------------------------------signIn-----------------------------------
  @override
  Future<Either<Exception, AuthResponseEntity>> signIn(
      String email, String password, bool rememberMe) async {
    try {
      final apiResponse = await authRemoteDataSource.signIn(email, password);
      if (apiResponse.isRight) {
        await _cachUserSiginInData(apiResponse.right, rememberMe);
        return Right(AuthResponseEntity.toEntity(apiResponse.right));
      }
      return Left(apiResponse.left);
    } catch (e) {
      return Left(ApiException(message: 'Failed to sign in: ${e.toString()}'));
    }
  }

  Future<void> _cachUserSiginInData(
      SignInResponse response, bool rememberMe) async {
    try {
      await authLocalDataSource.cacheRememberMe(rememberMe);
      if (response.token != null) {
        //  Log.i('Caching user sign in data');
        await authLocalDataSource.cacheToken(response.token!);
        //Log.i('token cached successfully');
      }
    } catch (e) {
      Log.e('Error while caching user sign in data: ${e.toString()}');
      throw LocalStorageException(
          'failed to cache user sign Token ${e.toString()}');
    }
  }

  @override
  Future<Either<ApiException, void>> signup(SignUpRequestModel request) async {
    try {
      await authRemoteDataSource.signup(request);
      return const Right(null);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> forgetPassword(String email) async {
    try {
      await authRemoteDataSource.forgetPassword(email);
      return const Right(null);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> verifyResetCode(String resetCode) async {
    try {
      await authRemoteDataSource.verifyResetCode(resetCode);
      return const Right(null);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, void>> resetPassword(
      String email, String newPassword) async {
    try {
      await authRemoteDataSource.resetPassword(email, newPassword);
      return const Right(null);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
