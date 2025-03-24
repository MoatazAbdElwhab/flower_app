import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
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
}