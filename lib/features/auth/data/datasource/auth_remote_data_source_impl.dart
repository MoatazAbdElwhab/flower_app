import 'package:dartz/dartz.dart';
import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/auth/data/model/signup_response_model.dart';
import 'package:injectable/injectable.dart';
import '../model/signup_request_model.dart';
import 'auth_remote_data_source.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Either<ApiException, SignUpResponseModel>> signup(
      SignUpRequestModel request) async {
    Either<ApiException, Map<String, dynamic>> response =
        await _apiClient.post(
      ApiConstants.sinUpEndPoint,
      data: request.toJson(),
      requiresToken: false,
    );

    return response.fold(
      (error) {
        return Left(
          ApiException(
            message: error.message,
            statusCode: error.statusCode,
          ),
        );
      },
      (successData) {
        try {
          final signUpResponse = SignUpResponseModel.fromJson(successData);
          return Right(signUpResponse);
        } catch (e) {
          return Left(
            ApiException(
              message: e.toString(),
              statusCode: 500,
            ),
          );
        }
      },
    );
  }
}
