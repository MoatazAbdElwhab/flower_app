import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/profile/data/models/update_profile_data/update_profile_request.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';

abstract class ProfileRepository {
  Future<Either<Exception, UserData>> getUserData();

  Future<Either<ApiException, void>> editUserProfileData(
      UpdateProfileRequest updateProfileRequest);

  Future<Either<Exception, void>> logout();
}
