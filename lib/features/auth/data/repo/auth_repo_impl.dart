import 'package:dartz/dartz.dart';

import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/data/datasource/auth_remote_data_source.dart';

import 'package:flower_app/features/auth/data/model/signup_request_model.dart';

import 'package:flower_app/features/auth/data/model/signup_response_model.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/auth_repo.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoImpl(this._authRemoteDataSource);
  @override
  Future<Either<ApiException, SignUpResponseModel>> signup(
      SignUpRequestModel request) async {
    var response = await _authRemoteDataSource.signup(request);
    return response;
  }
}
