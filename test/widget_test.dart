// test/widget_test.dart

import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/auth/domain/entities/auth_response_entity.dart';
import 'package:flower_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:either_dart/either.dart';
import 'helpers/mock_data/auth_mock_data.dart';
import 'helpers/mocks/auth_mocks.dart';
import 'helpers/mocks/auth_mocks.mocks.dart';

/// Main test suite for Authentication features
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  group('Authentication Service Tests', () {
    late MockSignInUseCase signInUseCase;
    late MockLocalStorageClient localStorageClient;
    late AuthCubit authCubit;

    /// Setup before each test
    setUp(() {
      signInUseCase = MockSignInUseCase();
      localStorageClient = MockLocalStorageClient();
      
      // Setup default mock behavior
      when(localStorageClient.getData(any)).thenReturn('false');
      when(localStorageClient.saveData(any, any)).thenAnswer((_) async => true);
      
      authCubit = AuthCubit(
         signInUseCase,
        localStorageClient,
      );
    });

    /// Cleanup after each test
    tearDown(() {
      authCubit.close();
    });

    group('Login Functionality', () {
      test('successful login updates auth state with token', () async {
        // Arrange
        authCubit.loginemailController.text = AuthMockData.validEmail;
        authCubit.loginpasswordController.text = AuthMockData.validPassword;
        
        signInUseCase.setupSuccessResponse(
          email: AuthMockData.validEmail, 
          password: AuthMockData.validPassword
        );
        
        // Act
        await authCubit.signIn();
        
        // Assert
        expect(authCubit.state.signInState, isA<BaseSuccessState>());
        expect(authCubit.state.authResponse?.token, isNotNull);
      });

      test('failed login produces appropriate error state', () async {
        // Arrange
        authCubit.loginemailController.text = AuthMockData.validEmail;
        authCubit.loginpasswordController.text = AuthMockData.invalidPassword;
        
        signInUseCase.setupErrorResponse(
          email: AuthMockData.validEmail,
          password: AuthMockData.invalidPassword
        );
        
        // Act
        await authCubit.signIn();
        
        // Assert
        expect(authCubit.state.signInState, isA<BaseErrorState>());
      });
    });

    group('Remember Me Functionality', () {
      test('setting remember me persists preference', () async {
        // Act
        authCubit.setRememberMe(true);
        await Future.delayed(const Duration(milliseconds: 50));
        
        // Assert
        expect(authCubit.rememberMe, isTrue);
        verify(localStorageClient.saveData('rememberMe', 'true')).called(1);
      });
    });
    
    group('Token Management', () {
      test('auth response is properly stored after login', () async {
        // Arrange
        authCubit.loginemailController.text = AuthMockData.validEmail;
        authCubit.loginpasswordController.text = AuthMockData.validPassword;
        
        signInUseCase.setupSuccessResponse(
          email: AuthMockData.validEmail, 
          password: AuthMockData.validPassword,
          token: 'test_token_123'
        );
        
        // Act
        await authCubit.signIn();
        
        // Assert
        expect(authCubit.state.authResponse?.token, equals('test_token_123'));
      });
    });
  });
}
