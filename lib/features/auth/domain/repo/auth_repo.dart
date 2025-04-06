import 'package:dartz/dartz.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../data/model/signup_request_model.dart';

// features/auth/domain/repo/auth_repo.dart

import 'package:either_dart/either.dart';
import '../entities/auth_response_entity.dart';

abstract class AuthRepo {
  Future<Either<ApiException, Unit>> signup(SignUpRequestModel request);
  //-----------------------------signIn-----------------------------------
  Future<Either<Exception, AuthResponseEntity>> signIn(
      String email, String password, bool rememberMe);
}
