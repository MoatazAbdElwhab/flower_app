import 'package:dartz/dartz.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo _authRepo;

  VerifyResetCodeUseCase(this._authRepo);

  Future<Either<ApiException, Unit>> call(String resetCode) {
    return _authRepo.verifyResetCode(resetCode);
  }
}
