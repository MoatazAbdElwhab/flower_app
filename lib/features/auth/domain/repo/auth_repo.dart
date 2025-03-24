// features/auth/domain/repo/auth_repo.dart

import 'package:either_dart/either.dart';
import 'package:flower_app/features/auth/data/model/response/sign_in_response/sign_in_response.dart';

abstract class AuthRepo {
  //-----------------------------signIn-----------------------------------
  Future<Either<Exception, SignInResponse>> signIn(
      String email, String password, bool rememberMe);
}
