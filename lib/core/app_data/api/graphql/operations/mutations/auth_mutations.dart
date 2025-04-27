// core/app_data/api/graphql/operations/mutations/auth_mutations.dart
/// GraphQL mutations related to authentication
class AuthMutations {
  static String signIn() {
    return '''
      mutation SignIn(\$email: String!, \$password: String!) {
        signIn(input: { email: \$email, password: \$password }) {
          token
          user {
            id
            name
            email
            phone
            profileImage
          }
        }
      }
    ''';
  }

  static String signInAsGuest() {
    return '''
      mutation SignInAsGuest {
        signInAsGuest {
          token
          user {
            id
            name
            isGuest
          }
        }
      }
    ''';
  }

  /// Sign up mutation
  static String signUp() {
    return '''
      mutation SignUp(
        \$name: String!,
        \$email: String!,
        \$password: String!,
        \$phone: String!
      ) {
        signUp(input: {
          name: \$name,
          email: \$email,
          password: \$password,
          phone: \$phone
        }) {
          token
          user {
            id
            name
            email
            phone
            profileImage
          }
        }
      }
    ''';
  }

  /// Forgot password mutation
  static String forgotPassword() {
    return '''
      mutation ForgotPassword(\$email: String!) {
        forgotPassword(email: \$email) {
          success
          message
        }
      }
    ''';
  }

  /// Verify reset code mutation
  static String verifyResetCode() {
    return '''
      mutation VerifyResetCode(\$resetCode: String!) {
        verifyResetCode(resetCode: \$resetCode) {
          success
          message
        }
      }
    ''';
  }

  /// Reset password mutation
  static String resetPassword() {
    return '''
      mutation ResetPassword(\$token: String!, \$newPassword: String!) {
        resetPassword(token: \$token, newPassword: \$newPassword) {
          success
          message
        }
      }
    ''';
  }
  
  /// Logout mutation
  static String logout() {
    return '''
      mutation Logout {
        logout {
          success
          message
        }
      }
    ''';
  }
}
