// features/auth/data/datasource/remote_data_source/auth_remote_data_source_impl.dart

import 'package:either_dart/src/either.dart';
import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart';
import 'package:flower_app/features/auth/data/model/response/sign_in_response/sign_in_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

//---------------------------------signIn-----------------------------------
  @override
  Future<Either<ApiException, SignInResponse>> signIn(
      String email, String password) async {
    try {
      final response = await _apiClient.post(
        // 'auth/signin',
        ApiConstants.logInEndPoint,
        data: {
          'email': email,
          'password': password,
        },
        requiresToken: false,
      );

      final signInResponse = SignInResponse.fromJson(response);
      //Log.d('signIn response: ${Right(signInResponse)}');
      return Right(signInResponse);
    } catch (e) {
      Log.e('Error during sign in: $e');
      return Left(ApiException(message: 'Failed to sign in: $e'));
    }
  }
}
