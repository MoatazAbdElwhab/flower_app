import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flower_app/features/profile/data/models/profile_data_response/profile_data_response.dart';
import 'package:flower_app/features/profile/data/models/profile_data_response/user_data_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileApiRemoteDataSource extends ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileApiRemoteDataSource(this._apiClient);

  @override
  Future<UserDataModel> getUserData() async {
    final response = await _apiClient.get(
      ApiConstants.profileDataEndPoint,
    );

    return ProfileDataResponse.fromJson(response).user;
  }
}
