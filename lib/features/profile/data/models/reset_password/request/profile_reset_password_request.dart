class ProfileResetPasswordRequest {
  String? password;
  String? newPassword;

  ProfileResetPasswordRequest({this.password, this.newPassword});

  factory ProfileResetPasswordRequest.fromJson(Map<String, dynamic> json) {
    return ProfileResetPasswordRequest(
      password: json['password'] as String?,
      newPassword: json['newPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'password': password,
        'newPassword': newPassword,
      };
}
