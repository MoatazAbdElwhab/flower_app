// features/auth/data/model/response/sign_in_response/sign_in_response.dart
import 'user.dart';

class SignInResponse {
  String? message;
  User? user;
  String? token;

  SignInResponse({this.message, this.user, this.token});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user?.toJson(),
        'token': token,
      };
}
