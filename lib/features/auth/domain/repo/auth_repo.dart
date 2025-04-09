import 'package:either_dart/either.dart';
import 'package:flower_app/features/auth/data/model/signup_request_model.dart';

import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../entities/auth_response_entity.dart';

abstract class AuthRepo {
  //-----------------------------signIn-----------------------------------
  Future<Either<Exception, AuthResponseEntity>> signIn(
      String email, String password, bool rememberMe);
  Future<Either<ApiException, void>> signup(SignUpRequestModel request);
  Future<Either<ApiException, void>> forgetPassword(String email);
  Future<Either<ApiException, void>> verifyResetCode(String resetCode);
  Future<Either<ApiException, void>> resetPassword(
      String email, String newPassword);
}
