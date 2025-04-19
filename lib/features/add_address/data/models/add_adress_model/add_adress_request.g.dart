// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_adress_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAdressRequest _$AddAdressRequestFromJson(Map<String, dynamic> json) =>
    AddAdressRequest(
      street: json['street'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      latValue: json['lat'] as String,
      longValue: json['long'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$AddAdressRequestToJson(AddAdressRequest instance) =>
    <String, dynamic>{
      'street': instance.street,
      'phone': instance.phone,
      'city': instance.city,
      'lat': instance.latValue,
      'long': instance.longValue,
      'username': instance.username,
    };
