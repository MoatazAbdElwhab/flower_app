// features/auth/data/datasource/remote_data_source/auth_remote_data_source_contract.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/data/model/reset_password_response_model.dart';
import 'package:flower_app/features/auth/data/model/response/sign_in_response/sign_in_response.dart';

import '../../model/signup_request_model.dart';
import '../../model/signup_response_model.dart';

abstract class AuthRemoteDataSourceContract {
  Future<Either<ApiException, SignInResponse>> signIn(
      String email, String password);
  Future<SignUpResponseModel> signup(SignUpRequestModel request);
  Future<void> forgetPassword(String email);
  Future<void> verifyResetCode(String resetCode);
  Future<ResetPasswordResponseModel> resetPassword(
      String email, String newPassword);
}
