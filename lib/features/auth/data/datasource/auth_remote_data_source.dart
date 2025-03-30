import 'package:flower_app/features/auth/data/model/reset_password_response_model.dart';
import 'package:flower_app/features/auth/data/model/signup_response_model.dart';
import '../model/signup_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignUpResponseModel> signup(SignUpRequestModel request);
  Future<void> forgetPassword(String email);
  Future<void> verifyResetCode(String resetCode);
  Future<ResetPasswordResponseModel> resetPassword(
      String email, String newPassword);
}
