// features/auth/domain/use_case/sign_in_use_case.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/features/auth/data/model/response/sign_in_response/sign_in_response.dart';
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase {
  final AuthRepo _authRepo;

  SignInUseCase(this._authRepo);

  Future<Either<Exception, SignInResponse>> call(
      String email, String password, bool rememberMe) async {
    return await _authRepo.signIn(email, password, rememberMe);
  }
}
