import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/features/auth/data/model/reset_password_response_model.dart';
import 'package:flower_app/features/auth/data/model/signup_response_model.dart';
import 'package:injectable/injectable.dart';
import '../model/signup_request_model.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<SignUpResponseModel> signup(SignUpRequestModel request) async {
    var response = await _apiClient.post(
      ApiConstants.sinUpEndPoint,
      data: request.toJson(),
      requiresToken: false,
    );
    var responseModel = SignUpResponseModel.fromJson(response);
    return responseModel;
  }

  @override
  Future<void> forgetPassword(String email) async {
    await _apiClient.post(
      ApiConstants.forgetPasswordEndPoint,
      data: {"email": email},
      requiresToken: false,
    );
  }

  @override
  Future<void> verifyResetCode(String resetCode) async {
    await _apiClient.post(
      ApiConstants.verifyResetCodeEndPoint,
      data: {"resetCode": resetCode},
      requiresToken: false,
    );
  }

  @override
  Future<ResetPasswordResponseModel> resetPassword(
      String email, String newPassword) async {
    var response = await _apiClient.put(
      ApiConstants.resetPasswordEndPoint,
      data: {"email": email, "newPassword": newPassword},
      requiresToken: false,
    );
    var responseModel = ResetPasswordResponseModel.fromJson(response);
    return responseModel;
  }
}
