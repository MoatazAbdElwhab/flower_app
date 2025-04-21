import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flower_app/features/profile/data/models/profile_data_response/profile_data_response.dart';
import 'package:flower_app/features/profile/data/models/profile_data_response/user_data_model.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/data/models/reset_password/response/profile_reset_password_response.dart';
import 'package:flower_app/features/profile/data/models/update_address_response.dart';
import 'package:flower_app/features/profile/data/models/update_profile_data/update_profile_request.dart';
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

  @override
  Future<void> editProfileData(
      UpdateProfileRequest updateProfileRequest) async {
    await _apiClient.put(
      ApiConstants.editProfileEndPoint,
      data: updateProfileRequest.toJson(),
      requiresToken: true,
    );
  }

  @override
  Future<void> logout() async {
    final response = await _apiClient.get(
      ApiConstants.logOutEndPoint,
      requiresToken: true,
    );
    return response;
  }

  @override
  Future<ProfileResetPasswordResponse> profileResetPassword(
      ProfileResetPasswordRequest request) async {
    final response = await _apiClient.patch(
      ApiConstants.changePasswordEndPoint,
      data: request.toJson(),
      requiresToken: true,
    );

    return ProfileResetPasswordResponse.fromJson(response);
  }

  @override
  Future<void> deleteAddress(String id) async {
    await _apiClient.delete(
      '${ApiConstants.addressesEndPoint}/$id',
      requiresToken: true,
    );
  }

  @override
  Future<List<Address>> updateAddress(Address address) async {
    final apiResponse = await _apiClient.patch(
      '${ApiConstants.addressesEndPoint}/${address.id}',
      data: address.toJson(),
      requiresToken: true,
    );
    final updatedAddressResponse = UpdateAddressResponse.fromJson(apiResponse);
    return updatedAddressResponse.addresses;
  }
}
