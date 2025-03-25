// features/auth/domain/repo/auth_repo.dart

import 'package:either_dart/either.dart';
import '../entities/auth_response_entity.dart';

abstract class AuthRepo {
  //-----------------------------signIn-----------------------------------
  Future<Either<Exception, AuthResponseEntity>> signIn(
      String email, String password, bool rememberMe);
}
