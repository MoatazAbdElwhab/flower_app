import 'package:flower_app/features/profile/data/models/profile_data_response/user_data_model.dart';

class ProfileDataResponse {
  final String? message;
  final UserDataModel user;

  const ProfileDataResponse({this.message, required this.user});

  factory ProfileDataResponse.fromJson(Map<String, dynamic> json) {
    return ProfileDataResponse(
      message: json['message'] as String?,
      user: UserDataModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'user': user.toJson(),
      };
}
