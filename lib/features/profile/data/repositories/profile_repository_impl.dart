import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/data/models/reset_password/response/profile_reset_password_response.dart';
import 'package:flower_app/features/profile/data/models/update_profile_data/update_profile_request.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepositoryImpl(this._profileRemoteDataSource);

  @override
  Future<Either<Exception, UserData>> getUserData() async {
    try {
      final userData = await _profileRemoteDataSource.getUserData();
      return Right(userData.toEntity());
    } catch (e) {
      return Left(Exception(e));
    }
  }

  @override
  Future<Either<ApiException, void>> editUserProfileData(UpdateProfileRequest updateProfileRequest) async{
    try {
      await _profileRemoteDataSource.editProfileData(updateProfileRequest);
      return const Right(null);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, ProfileResetPasswordResponse>>
      profileResetPassword(ProfileResetPasswordRequest request) async {
    try {
      final response =
          await _profileRemoteDataSource.profileResetPassword(request);
      return Right(response);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
