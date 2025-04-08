// test/helpers/mocks/auth_mocks.dart

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flower_app/features/auth/domain/ues_case/sign_in_use_case.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';
import 'package:flower_app/features/auth/domain/repo/auth_repo.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:either_dart/either.dart';
import 'package:flower_app/features/auth/domain/entities/auth_response_entity.dart';
import '../mock_data/auth_mock_data.dart';

//---------------here i implement the signinusecasemock from signinusecase.dart
class MockSignInUseCase extends Mock implements SignInUseCase {
  final Map<String, Either<Exception, AuthResponseEntity>> _responses = {};
  final List<Map<String, dynamic>> _callLog = [];

  Either<Exception, AuthResponseEntity> _defaultResponse = 
    const  Right(AuthMockData.mockAuthResponse);

  void reset() {
    _responses.clear();
    _callLog.clear();
    _defaultResponse =const Right(AuthMockData.mockAuthResponse);
  }

  void setupResponse({
    required String email, 
    required String password, 
    bool rememberMe = false, 
    required Either<Exception, AuthResponseEntity> response
  }) {
    _responses['$email:$password:$rememberMe'] = response;
  }

  void setupDefaultResponse(Either<Exception, AuthResponseEntity> response) {
    _defaultResponse = response;
  }

  void setupSuccessResponse({
    required String email,
    required String password,
    bool rememberMe = false,
    String token = AuthMockData.mockToken,
    String message = 'Success',
  }) {
    setupResponse(
      email: email,
      password: password,
      rememberMe: rememberMe,
      response: Right(AuthResponseEntity(token: token, message: message))
    );
  }

//-----------------here i implement the setupErrorResponse from signinusecase.dart
  void setupErrorResponse({
    required String email,
    required String password,
    bool rememberMe = false,
    String message = AuthMockData.invalidCredentialsMessage,
  }) {
    setupResponse(
      email: email,
      password: password,
      rememberMe: rememberMe,
      response: Left(Exception(message))
    );
  }

 ///get the call history of the signinusecase
  List<Map<String, dynamic>> get callHistory => _callLog;



///-----------------here i implement the call method from signinusecase.dart
  @override
  Future<Either<Exception, AuthResponseEntity>> call(
      String email, String password, bool rememberMe) async {
    // Log this call
    _callLog.add({
      'email': email,
      'password': password,
      'rememberMe': rememberMe,
    });
    
    // Use stored response if available for this email/password combo
    final key = '$email:$password:$rememberMe';
    if (_responses.containsKey(key)) {
      return _responses[key]!;
    }
        return _defaultResponse;
  }
}


//---------------here i implement the mockauthrepo from auth_repo.dart
@GenerateMocks([
  LocalStorageClient,
  AuthRepo,
  AuthLocalDataSourceContract,
  DialogUtils,
])
void main() {}
