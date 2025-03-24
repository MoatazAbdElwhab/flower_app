import 'package:json_annotation/json_annotation.dart';

part 'signup_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;
  @JsonKey(name: "rePassword")
  final String? rePassword;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "gender")
  final String? gender;

  SignUpRequestModel ({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
    this.gender,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) {
    return _$SignUpRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignUpRequestModelToJson(this);
  }
}


