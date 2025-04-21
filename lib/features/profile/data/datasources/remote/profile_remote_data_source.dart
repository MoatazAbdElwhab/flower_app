import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/profile/data/models/profile_data_response/user_data_model.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/data/models/reset_password/response/profile_reset_password_response.dart';

import '../../models/update_profile_data/update_profile_request.dart';

abstract class ProfileRemoteDataSource {
  Future<UserDataModel> getUserData();
  Future<void> editProfileData(UpdateProfileRequest updateProfileRequest);
  Future<void> logout();

  Future<ProfileResetPasswordResponse> profileResetPassword(
      ProfileResetPasswordRequest request);

  Future<void> deleteAddress(String id);

  Future<List<Address>> updateAddress(Address address);

}
