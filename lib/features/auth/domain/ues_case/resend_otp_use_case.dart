import 'package:dartz/dartz.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResendOtpUseCase {
  final AuthRepo _authRepo;

  ResendOtpUseCase(this._authRepo);

  Future<Either<ApiException, Unit>> call(String email) {
    return _authRepo.forgetPassword(email);
  }
}
