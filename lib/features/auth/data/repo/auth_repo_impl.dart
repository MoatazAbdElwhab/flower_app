import 'package:dartz/dartz.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flower_app/features/auth/data/model/signup_request_model.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource);

  // Unit is from Either package and it represents void

  @override
  Future<Either<ApiException, Unit>> signup(SignUpRequestModel request) async {
    try {
      await _authRemoteDataSource.signup(request);
      return const Right(unit);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> forgetPassword(String email) async {
    try {
      await _authRemoteDataSource.forgetPassword(email);
      return const Right(unit);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> verifyResetCode(String resetCode) async {
    try {
      await _authRemoteDataSource.verifyResetCode(resetCode);
      return const Right(unit);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, Unit>> resetPassword(
      String email, String newPassword) async {
    try {
      await _authRemoteDataSource.resetPassword(email, newPassword);
      return const Right(unit);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
