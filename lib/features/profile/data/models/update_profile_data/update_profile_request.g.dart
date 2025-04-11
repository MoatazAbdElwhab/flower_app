// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequest(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestToJson(
        UpdateProfileRequest instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
    };
