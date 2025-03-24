import 'package:dartz/dartz.dart';
import 'package:flower_app/features/auth/data/model/signup_response_model.dart';
import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../model/signup_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<Either<ApiException, SignUpResponseModel>> signup(SignUpRequestModel request);
}