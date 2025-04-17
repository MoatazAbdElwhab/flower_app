import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/update_profile_data/update_profile_request.dart';
import '../repositories/profile_repository.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepository _profileRepository;

  EditProfileUseCase(this._profileRepository);

  Future<Either<ApiException, void>> call(
          UpdateProfileRequest updateProfileRequest) async =>
      await _profileRepository.editUserProfileData(updateProfileRequest);
}
