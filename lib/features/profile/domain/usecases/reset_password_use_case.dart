// features/profile/domain/usecases/reset_password_use_case.dart
import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/data/models/reset_password/response/profile_reset_password_response.dart';
import 'package:flower_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final ProfileRepository _profileRepository;

  ResetPasswordUseCase(this._profileRepository);

  Future<Either<ApiException, ProfileResetPasswordResponse>> call(
      ProfileResetPasswordRequest request) async {
    return await _profileRepository.profileResetPassword(request);
  }
}
