import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/profile/domain/entities/user_data.dart';

class UserDataModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final List<dynamic>? wishlist;
  final List<Address>? addresses;
  final DateTime? createdAt;

  const UserDataModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    List<Address>? addressList;

    if (json['addresses'] != null && json['addresses'] is List) {
      addressList = (json['addresses'] as List)
          .map((addressJson) => Address.fromJson(addressJson as Map<String, dynamic>))
          .toList();
    }
    return UserDataModel(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      role: json['role'] as String?,
      wishlist: json['wishlist'] as List<dynamic>?,
      addresses: addressList,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'gender': gender,
        'phone': phone,
        'photo': photo,
        'role': role,
        'wishlist': wishlist,
        'addresses': addresses,
        'createdAt': createdAt?.toIso8601String(),
      };

  UserData toEntity() => UserData(
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        email: email ?? '',
        gender: gender ?? '',
        phone: phone ?? '',
        photo: photo ?? '',
        addresses: addresses ?? [],
      );
}
