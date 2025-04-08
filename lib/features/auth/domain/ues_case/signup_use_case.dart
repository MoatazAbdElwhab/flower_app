import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../data/model/signup_request_model.dart';
import '../repo/auth_repo.dart';

@injectable
class SignupUseCase {
  final AuthRepo _authRepo;

  SignupUseCase(this._authRepo);

  Future<Either<ApiException, void>> call(SignUpRequestModel request) async =>
      await _authRepo.signup(request);
}
