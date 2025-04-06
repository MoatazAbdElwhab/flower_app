// features/auth/domain/entities/user_entity.dart
import 'package:flower_app/features/auth/data/model/response/sign_in_response/user.dart';

class UserEntity {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final List<dynamic>? wishlist;
  final List<dynamic>? addresses;
  final DateTime? createdAt;

  const UserEntity({
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

  static UserEntity toEntity(User model) {
    return UserEntity(
      id: model.id,
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      gender: model.gender,
      phone: model.phone,
      photo: model.photo,
      role: model.role,
      wishlist: model.wishlist,
      addresses: model.addresses,
      createdAt: model.createdAt,
    );
  }

  static User fromEntity(UserEntity entity) {
    return User(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      gender: entity.gender,
      phone: entity.phone,
      photo: entity.photo,
      role: entity.role,
      wishlist: entity.wishlist,
      addresses: entity.addresses,
      createdAt: entity.createdAt,
    );
  }
}
