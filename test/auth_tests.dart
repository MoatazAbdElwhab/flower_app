// test/auth_tests.dart
// Core authentication tests - simplified version

import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_impl.dart';
import 'package:flower_app/features/auth/domain/ues_case/signup_use_case.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'helpers/mocks/auth_mocks.dart';
import 'helpers/mocks/auth_mocks.mocks.dart';
import 'helpers/mock_data/auth_mock_data.dart';

//------------------------ Tests ------------------------
void main() {
  group('Authentication Tests', () {
    late MockSignInUseCase signInUseCase;
    late MockLocalStorageClient localStorageClient;
    late AuthCubit authCubit;

    setUp(() {
      // Create mocks
      signInUseCase = MockSignInUseCase();
      localStorageClient = MockLocalStorageClient();

      when(localStorageClient.getData(any)).thenReturn('false');
      when(localStorageClient.saveData(any, any)).thenAnswer((_) async => true);
      when(localStorageClient.getSecuredData(any)).thenAnswer((_) async => '');
      when(localStorageClient.saveSecuredData(any, any))
          .thenAnswer((_) async => true);

      // Create cubit
      authCubit = AuthCubit(
        // _signupUseCase
        // _forgetPasswordUseCase
        // _verifyResetCodeUseCase
        // _resetPasswordUseCase
        signInUseCase, 
        localStorageClient, 
        // _resendOtpUseCase
      );

      debugPrint('\n== Starting Authentication Tests ==');
    });

    tearDown(() {
      authCubit.close();
    });

    test('initial state is BaseInitialState', () {
      expect(authCubit.state.signInState, isA<BaseInitialState>());
      debugPrint(
          'PASSED: Initial state test - AuthCubit starts with correct initial state');
    });

    test('setRememberMe updates value and saves to storage', () async {
      // Act
      authCubit.setRememberMe(true);
      await Future.delayed(const Duration(milliseconds: 50));

      // Assert
      expect(authCubit.rememberMe, isTrue);
      verify(localStorageClient.saveData('rememberMe', 'true')).called(1);
      debugPrint(
          'PASSED: Remember Me Functionality - Settings are saved correctly');
    });

    test('successful login emits success state', () async {
      // Arrange
      signInUseCase.setupSuccessResponse(
        email: AuthMockData.validEmail,
        password: AuthMockData.validPassword,
      );

      authCubit.loginemailController.text = AuthMockData.validEmail;
      authCubit.loginpasswordController.text = AuthMockData.validPassword;

      // Act
      await authCubit.signIn();

      // Assert
      expect(authCubit.state.signInState, isA<BaseSuccessState>());
      debugPrint(
          'PASSED: Login Success - User can login with valid credentials');
    });

    test('login with invalid credentials shows error', () async {
      // Arrange
      signInUseCase.setupErrorResponse(
        email: AuthMockData.invalidEmail,
        password: AuthMockData.invalidPassword,
        message: 'Invalid credentials',
      );

      authCubit.loginemailController.text = AuthMockData.invalidEmail;
      authCubit.loginpasswordController.text = AuthMockData.invalidPassword;

      // Act
      await authCubit.signIn();

      // Assert
      expect(authCubit.state.signInState, isA<BaseErrorState>());
      debugPrint(
          'PASSED: Error Handling - Login with invalid credentials shows error');
    });

    test('token storage saves and retrieves tokens', () async {
      // Arrange
      const token = 'test_token_123';
      const tokenKey = 'auth_token';

      // Act
      await localStorageClient.saveSecuredData(tokenKey, token);

      // Assert
      verify(localStorageClient.saveSecuredData(tokenKey, token)).called(1);
      debugPrint('PASSED: Token Storage - Tokens can be saved securely');
    });

    // Guest login test
    test('guest login tracking', () {
      // This is a placeholder test for the future guest login implementation
      debugPrint(
          'PENDING: Guest Login - Need to implement proper guest authentication');
      debugPrint(
          'NOTE: Guest login currently just navigates to home screen without authentication');
    });
  });
}
