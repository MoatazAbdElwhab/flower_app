import 'package:dartz/dartz.dart';

import '../../../../core/error_handling/exceptions/api_exception.dart';
import '../../data/model/signup_request_model.dart';
import '../../data/model/signup_response_model.dart';

abstract class AuthRepo {
  Future<Either<ApiException, SignUpResponseModel>> signup(SignUpRequestModel request);
}