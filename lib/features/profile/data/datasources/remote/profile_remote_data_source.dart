import 'package:flower_app/features/profile/data/models/profile_data_response/user_data_model.dart';

import '../../models/update_profile_data/update_profile_request.dart';

abstract class ProfileRemoteDataSource {
  Future<UserDataModel> getUserData();
  Future<void> editProfileData(UpdateProfileRequest updateProfileRequest);
}
