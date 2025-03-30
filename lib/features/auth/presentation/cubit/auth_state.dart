import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthState extends Equatable {
  final BaseState? signUpState;
  final BaseState? forgetPasswordState;
  final BaseState? verifyResetCodeState;
  final BaseState? resetPasswordState;
  const AuthState({
    this.signUpState,
    this.forgetPasswordState,
    this.verifyResetCodeState,
    this.resetPasswordState,
  });

  AuthState copyWith({
    BaseState? signUpState,
    BaseState? forgetPasswordState,
    BaseState? verifyResetCodeState,
    BaseState? resetPasswordState,
  }) {
    return AuthState(
      signUpState: signUpState ?? this.signUpState,
      forgetPasswordState: forgetPasswordState ?? this.forgetPasswordState,
      verifyResetCodeState: verifyResetCodeState ?? this.verifyResetCodeState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }

  @override
  List<Object?> get props => [
        signUpState,
        forgetPasswordState,
        verifyResetCodeState,
        resetPasswordState
      ];
}

// class AuthInitial extends AuthState {}

// class AuthLoading extends BaseLoadingState implements AuthState {}

// class AuthSuccess<T> extends BaseSuccessState<T> implements AuthState {
//   AuthSuccess({super.data});
// }

// class AuthError extends BaseErrorState implements AuthState {
//   AuthError(super.errorMessage);
// }
// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'auth_state.freezed.dart';
//
// @Freezed()
// class AuthState<T> with _$AuthState<T> {
//   const factory AuthState.initial() = _Initial<T>;
//   const factory AuthState.loading() = AuthLoading<T>;
//   const factory AuthState.success(T data) = AuthSuccess<T>;
//   const factory AuthState.error(String message) = AuthError<T>;
//   const factory AuthState.selectGender(String selectedGender) = SelectGender<T>;
// }
