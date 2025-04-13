// features/profile/presentation/cubit/profile_state.dart
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.getUserDataState, 
    this.editProfileState,
    this.resetPasswordState,
    this.isResetPasswordFormValid = false,
  });

  final BaseState? getUserDataState;
  final BaseState? editProfileState;
  final BaseState? resetPasswordState;
  final bool isResetPasswordFormValid;

  ProfileState copyWith({
    BaseState? getUserDataState,
    BaseState? editProfileState,
    BaseState? resetPasswordState,
    UserData? userData,
    bool? isResetPasswordFormValid,
  }) {
    return ProfileState(
      getUserDataState: getUserDataState ?? this.getUserDataState,
      editProfileState: editProfileState ?? this.editProfileState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      isResetPasswordFormValid: isResetPasswordFormValid ?? this.isResetPasswordFormValid,
    );
  }

  @override
  List<Object?> get props => [
        getUserDataState,
        editProfileState,
        resetPasswordState,
        isResetPasswordFormValid,
      ];
}
