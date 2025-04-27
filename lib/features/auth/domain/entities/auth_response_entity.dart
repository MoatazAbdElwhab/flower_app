// features/auth/domain/entities/auth_response_entity.dart
import 'package:flower_app/features/auth/data/model/response/sign_in_response/sign_in_response.dart';

import 'user_entity.dart';

class AuthResponseEntity {
  final String? message;
  final UserEntity? user;
  final String? token;
  final bool isGuest;

  const AuthResponseEntity({
    this.message,
    this.user,
    this.token,
    this.isGuest = false,
  });

  static AuthResponseEntity toEntity(SignInResponse model) {
    return AuthResponseEntity(
      message: model.message,
      user: model.user != null ? UserEntity.toEntity(model.user!) : null,
      token: model.token,
      isGuest: model.isGuest ?? false,
    );
  }

  static SignInResponse fromEntity(AuthResponseEntity entity) {
    return SignInResponse(
      message: entity.message,
      user: entity.user != null ? UserEntity.fromEntity(entity.user!) : null,
      token: entity.token,
      isGuest: entity.isGuest,
    );
  }
}
