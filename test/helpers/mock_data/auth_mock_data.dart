// test/helpers/mock_data/auth_mock_data.dart

import 'package:flower_app/features/auth/domain/entities/auth_response_entity.dart';


///---------------this file contain all mock(dummies) data for auth feature-----------------///
class AuthMockData {
  static const String validEmail = 'shimaa.hossni.2015@gmail.com';
  static const String validPassword = 'Ahmed@123';
  static const String invalidEmail = 'invalid@example.com';
  static const String invalidPassword = 'wrongpassword';
    static const String mockToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjdkY2M4NTQ4MzZlZThiZTcwNjI0ZTRlIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3NDI5NTI2NjF9.7PzIMb8FF3k7rhOK6PdR7ecI3P829PpeVHOkNZ2ff5w';
  
  /// Mockerror messages
  static const String invalidCredentialsMessage = 'Invalid credentials';
  static const String networkErrorMessage = 'Network error occurred';
  static const String serverErrorMessage = 'Server error occurred';

  /// Mock successful authentication response
  static const mockAuthResponse = AuthResponseEntity(
    token: mockToken,
    message: 'Success',
  );

  /// Mock error response
  static const mockErrorResponse = AuthResponseEntity(
    token: null,
    message: invalidCredentialsMessage,
  );

  /// Mock guest response
  static const mockGuestResponse = AuthResponseEntity(
    token: mockToken,
    message: 'Guest login successful',
  );
}
