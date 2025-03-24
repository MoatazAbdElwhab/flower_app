// features/auth/presentation/cubit/auth_state.dart
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  BaseState? signInState;

  AuthState({
    required this.signInState,
  });

  AuthState copyWith({BaseState? signInState}) {
    return AuthState(
      signInState: signInState ?? this.signInState,
    );
  }

  @override
  List<Object?> get props => [signInState];
}
