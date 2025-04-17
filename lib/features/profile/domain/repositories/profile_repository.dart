import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/profile/data/models/add_adress_model/add_adress_request.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/data/models/reset_password/response/profile_reset_password_response.dart';
import 'package:flower_app/features/profile/data/models/update_profile_data/update_profile_request.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';

abstract class ProfileRepository {
  Future<Either<Exception, UserData>> getUserData();

  Future<Either<ApiException, void>> editUserProfileData(
      UpdateProfileRequest updateProfileRequest);

  Future<Either<Exception, void>> logout();


  Future<Either<ApiException, ProfileResetPasswordResponse>>
      profileResetPassword(ProfileResetPasswordRequest request);
  Future<Either<Exception, void>> addAddress(
      AddAdressRequest addAdressRequest);
}