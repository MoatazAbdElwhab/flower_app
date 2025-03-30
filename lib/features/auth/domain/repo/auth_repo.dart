import 'package:dartz/dartz.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../data/model/signup_request_model.dart';

abstract class AuthRepo {
  Future<Either<ApiException, Unit>> signup(SignUpRequestModel request);
  Future<Either<ApiException, Unit>> forgetPassword(String email);
  Future<Either<ApiException, Unit>> verifyResetCode(String resetCode);
  Future<Either<ApiException, Unit>> resetPassword(
      String email, String newPassword);
}
