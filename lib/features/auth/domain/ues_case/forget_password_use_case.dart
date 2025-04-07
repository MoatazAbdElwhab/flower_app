import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:either_dart/either.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<Either<ApiException, void>> call(String email) async =>
      await _authRepo.forgetPassword(email);
}
