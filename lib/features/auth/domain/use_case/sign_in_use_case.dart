// features/auth/domain/use_case/sign_in_use_case.dart

import 'package:either_dart/either.dart';
import '../entities/auth_response_entity.dart';
import '../repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  final AuthRepo _authRepo;

  SignInUseCase(this._authRepo);

  Future<Either<Exception, AuthResponseEntity>> call(
      String email, String password, bool rememberMe) async {
    return await _authRepo.signIn(email, password, rememberMe);
  }
}
