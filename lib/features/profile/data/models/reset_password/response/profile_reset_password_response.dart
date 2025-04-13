class ProfileResetPasswordResponse {
  String? message;
  String? token;

  ProfileResetPasswordResponse({this.message, this.token});

  factory ProfileResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResetPasswordResponse(
      message: json['message'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'token': token,
      };

  ProfileResetPasswordResponse copyWith({
    String? message,
    String? token,
  }) {
    return ProfileResetPasswordResponse(
      message: message ?? this.message,
      token: token ?? this.token,
    );
  }
}
