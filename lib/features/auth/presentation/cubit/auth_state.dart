import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';

import '../../domain/entities/auth_response_entity.dart';

class AuthState extends Equatable {
  const AuthState({
    this.signUpState,
    this.signInState,
    this.authResponse,
    this.forgetPasswordState,
    this.verifyResetCodeState,
    this.resetPasswordState,
  });

  final BaseState? signUpState;
  final BaseState? signInState;
  final BaseState? forgetPasswordState;
  final BaseState? verifyResetCodeState;
  final BaseState? resetPasswordState;
  final AuthResponseEntity? authResponse;

  AuthState copyWith({
    BaseState? signUpState,
    BaseState? signInState,
    BaseState? forgetPasswordState,
    BaseState? verifyResetCodeState,
    BaseState? resetPasswordState,
    AuthResponseEntity? authResponse,
  }) {
    return AuthState(
      signUpState: signUpState ?? this.signUpState,
      signInState: signInState ?? this.signInState,
      forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
      verifyResetCodeState: verifyResetCodeState ?? this.verifyResetCodeState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      authResponse: authResponse ?? this.authResponse,
    );
  }

  @override
  List<Object?> get props => [
        signUpState,
        signInState,
        forgetPasswordState,
        verifyResetCodeState,
        resetPasswordState,
        authResponse,
      ];
}
