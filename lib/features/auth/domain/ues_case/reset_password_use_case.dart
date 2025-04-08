import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);
  Future<Either<ApiException, void>> call(String email, String newPassword) {
    return _authRepo.resetPassword(email, newPassword);
  }
}
