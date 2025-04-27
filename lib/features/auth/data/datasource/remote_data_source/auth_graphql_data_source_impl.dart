// features/auth/data/datasource/remote_data_source/auth_graphql_data_source_impl.dart
import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../../core/app_data/api/graphql/graphql_service.dart';
import '../../../../../core/app_data/api/graphql/operations/mutations/auth_mutations.dart';
import '../../../../../core/error_handling/exceptions/api_exception.dart';
import '../../model/reset_password_response_model.dart';
import '../../model/response/sign_in_response/sign_in_response.dart';
import '../../model/signup_request_model.dart';
import '../../model/signup_response_model.dart';
import 'auth_remote_data_source_contract.dart';

@Injectable(as: AuthRemoteDataSourceContract)
class AuthGraphQLDataSourceImpl implements AuthRemoteDataSourceContract {
  final GraphQLService _graphQLService;
  final Logger _logger;

  @factoryMethod
  factory AuthGraphQLDataSourceImpl.from(GraphQLService graphQLService) {
    return AuthGraphQLDataSourceImpl(graphQLService, Logger());
  }

  AuthGraphQLDataSourceImpl(this._graphQLService, this._logger);

  @override
  Future<Either<ApiException, SignInResponse>> signIn(
      String email, String password) async {
    try {
      final result = await _graphQLService.mutate(
        document: AuthMutations.signIn(),
        variables: {
          'email': email,
          'password': password,
        },
      );

      final data = result.data;
      if (data == null || !data.containsKey('signIn')) {
        return Left(ApiException(message: 'Failed to sign in: No data returned'));
      }

      final signInResponse = SignInResponse.fromJson(data['signIn']);
      return Right(signInResponse);
    } on ApiException catch (e) {
      _logger.e('API error during sign in: ${e.message}');
      return Left(e);
    } catch (e) {
      _logger.e('Error during sign in: $e');
      return Left(ApiException(message: 'Failed to sign in: $e'));
    }
  }

  @override
  Future<Either<ApiException, SignInResponse>> signInAsGuest() async {
    try {
      final result = await _graphQLService.mutate(
        document: AuthMutations.signInAsGuest(),
      );

      final data = result.data;
      if (data == null || !data.containsKey('signInAsGuest')) {
        return Left(ApiException(message: 'Failed to sign in as guest: No data returned'));
      }

      final signInResponse = SignInResponse.fromJson(data['signInAsGuest']);
      return Right(signInResponse);
    } on ApiException catch (e) {
      _logger.e('API error during guest sign in: ${e.message}');
      return Left(e);
    } catch (e) {
      _logger.e('Error during guest sign in: $e');
      return Left(ApiException(message: 'Failed to sign in as guest: $e'));
    }
  }

  @override
  Future<SignUpResponseModel> signup(SignUpRequestModel request) async {
    try {
      final result = await _graphQLService.mutate(
        document: AuthMutations.signUp(),
        variables: {
          'name': request.firstName,
          'email': request.email,
          'password': request.password,
          'phone': request.phone ?? '',
        },
      );

      final data = result.data;
      if (data == null || !data.containsKey('signUp')) {
        throw ApiException(message: 'Failed to sign up: No data returned');
      }

      return SignUpResponseModel.fromJson(data['signUp']);
    } catch (e) {
      _logger.e('Error during sign up: $e');
      rethrow;
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      final result = await _graphQLService.mutate(
        document: AuthMutations.forgotPassword(),
        variables: {
          'email': email,
        },
      );

      final data = result.data;
      if (data == null || !data.containsKey('forgotPassword') || 
          data['forgotPassword']['success'] != true) {
        throw ApiException(message: data?['forgotPassword']?['message'] ?? 
            'Failed to process forgot password request');
      }
    } catch (e) {
      _logger.e('Error during forgot password: $e');
      rethrow;
    }
  }

  @override
  Future<void> verifyResetCode(String resetCode) async {
    // For verifyResetCode, you'll need to add this mutation to your AuthMutations class
    try {
      // This is assuming you have a verifyResetCode mutation in your GraphQL schema
      final result = await _graphQLService.mutate(
        document: '''
          mutation VerifyResetCode(\$resetCode: String!) {
            verifyResetCode(resetCode: \$resetCode) {
              success
              message
            }
          }
        ''',
        variables: {
          'resetCode': resetCode,
        },
      );

      final data = result.data;
      if (data == null || !data.containsKey('verifyResetCode') || 
          data['verifyResetCode']['success'] != true) {
        throw ApiException(message: data?['verifyResetCode']?['message'] ?? 
            'Failed to verify reset code');
      }
    } catch (e) {
      _logger.e('Error during reset code verification: $e');
      rethrow;
    }
  }

  @override
  Future<ResetPasswordResponseModel> resetPassword(
      String email, String newPassword) async {
    try {
      final result = await _graphQLService.mutate(
        document: AuthMutations.resetPassword(),
        variables: {
          'token': email, // Assuming the email is used as the token in your current implementation
          'newPassword': newPassword,
        },
      );

      final data = result.data;
      if (data == null || !data.containsKey('resetPassword')) {
        throw ApiException(message: 'Failed to reset password: No data returned');
      }

      return ResetPasswordResponseModel.fromJson(data['resetPassword']);
    } catch (e) {
      _logger.e('Error during password reset: $e');
      rethrow;
    }
  }
}
