// core/app_data/api/graphql/schema/auth_schema.dart
class AuthSchema {
  static const String userType = '''
    type User {
      id: ID!
      name: String!
      email: String!
      phone: String
      profileImage: String
      isGuest: Boolean!
    }
  ''';

  static const String authResponseType = '''
    type AuthResponse {
      token: String!
      user: User!
    }
  ''';

  static const String signInInputType = '''
    input SignInInput {
      email: String!
      password: String!
      rememberMe: Boolean
    }
  ''';

  static const String signUpInputType = '''
    input SignUpInput {
      name: String!
      email: String!
      password: String!
      phone: String!
    }
  ''';

  static const String passwordResetResponseType = '''
    type PasswordResetResponse {
      success: Boolean!
      message: String!
    }
  ''';

  static const String apiResponseType = '''
    type ApiResponse {
      success: Boolean!
      message: String!
    }
  ''';
}
