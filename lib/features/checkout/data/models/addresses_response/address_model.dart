import 'package:flower_app/features/checkout/domain/entities/address.dart';

class AddressModel {
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;
  final String? id;

  const AddressModel({
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
    this.id,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['street'] as String?,
        phone: json['phone'] as String?,
        city: json['city'] as String?,
        lat: json['lat'] as String?,
        long: json['long'] as String?,
        username: json['username'] as String?,
        id: json['_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'phone': phone,
        'city': city,
        'lat': lat,
        'long': long,
        'username': username,
        '_id': id,
      };

  Address toEntity() => Address(
        id: id ?? '',
        street: street ?? '',
        phone: phone ?? '',
        city: city ?? '',
        lat: lat ?? '',
        long: long ?? '',
        username: username ?? '',
      );
}
