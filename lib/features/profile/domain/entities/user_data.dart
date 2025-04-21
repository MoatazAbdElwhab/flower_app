import 'package:flower_app/features/checkout/domain/entities/address.dart';

class UserData {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final List<Address>? addresses;

  UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.addresses,
  });
  UserData copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? phone,
    String? photo,
    List<Address>? addresses,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      addresses: addresses ?? this.addresses,
    );
  }
}
