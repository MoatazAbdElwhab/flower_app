import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  // @JsonKey(name: "gender")
  // final String? gender;

  UpdateProfileRequest ({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    // this.gender,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateProfileRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateProfileRequestToJson(this);
  }
}


