import 'package:flower_app/features/auth/data/model/signup_response_model.dart';
import '../model/signup_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignUpResponseModel> signup(SignUpRequestModel request);
}