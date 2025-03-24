// features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/data/model/response/sign_in_response/sign_in_response.dart';

abstract class AuthRemoteDataSourceContract {
  Future<Either<ApiException, SignInResponse>> signIn(
      String email, String password);
}
