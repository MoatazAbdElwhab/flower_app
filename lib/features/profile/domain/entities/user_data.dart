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
}
