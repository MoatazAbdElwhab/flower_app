import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/auth_response_entity.dart';

class AuthState extends Equatable {
  final BaseState? signUpState;
  final BaseState? signInState;
  final AuthResponseEntity? authResponse;
  const AuthState({this.signUpState, this.signInState, this.authResponse});

  AuthState copyWith(
      {BaseState? signUpState,
      BaseState? signInState,
      AuthResponseEntity? authResponse}) {
    return AuthState(
      signUpState: signUpState ?? this.signUpState,
      signInState: signInState ?? this.signInState,
      authResponse: authResponse ?? this.authResponse,
    );
  }

  @override
  List<Object?> get props => [signUpState, signInState, authResponse];
}