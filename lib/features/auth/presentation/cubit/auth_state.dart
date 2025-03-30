import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthState extends Equatable {
  final BaseState? signUpState;
  final BaseState? signInState;
  final AuthResponseEntity? authResponse;

  const AuthState({this.signUpState, this.signInState,this.authResponse});
  const AuthState({
    required this.signInState,
    this.authResponse,
  });
  AuthState copyWith({
    BaseState? signInState,
    AuthResponseEntity? authResponse,
    BaseState? signUpState
  }) {
    return AuthState(
      signInState: signInState ?? this.signInState,
      authResponse: authResponse ?? this.authResponse,
      signUpState: signUpState ?? this.signUpState,
    );
  }

  @override
  List<Object> get props => [signUpState,signInState, authResponse];
}
