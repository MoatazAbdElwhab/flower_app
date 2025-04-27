// features/auth/domain/ues_case/sign_in_as_guest_use_case.dart
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../data/model/response/sign_in_response/sign_in_response.dart';
import '../entities/auth_response_entity.dart';
import '../repo/auth_repo.dart';

/// Use case for signing in as a guest user
@injectable
class SignInAsGuestUseCase {
  final AuthRepo _authRepo;

  /// Constructor taking auth repository
  SignInAsGuestUseCase(this._authRepo);

  /// Sign in as guest and get response
  ///
  /// Returns [AuthResponseEntity] on success with guest token
  /// Returns [Exception] on failure
  Future<Either<Exception, AuthResponseEntity>> call() {
    return _authRepo.signInAsGuest();
  }
}
