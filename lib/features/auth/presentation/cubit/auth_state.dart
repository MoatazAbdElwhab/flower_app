// features/auth/presentation/cubit/auth_state.dart
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final BaseState? signInState;
  final AuthResponseEntity? authResponse;

  const AuthState({
    required this.signInState,
    this.authResponse,
  });

  AuthState copyWith({
    BaseState? signInState,
    AuthResponseEntity? authResponse,
  }) {
    return AuthState(
      signInState: signInState ?? this.signInState,
      authResponse: authResponse ?? this.authResponse,
    );
  }

  @override
  List<Object?> get props => [signInState, authResponse];
}
