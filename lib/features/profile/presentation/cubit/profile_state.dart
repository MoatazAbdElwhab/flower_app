// features/profile/presentation/cubit/profile_state.dart
part of 'profile_cubit.dart';

class ProfileState extends Equatable {

  const ProfileState({
    this.getUserDataState, 
    this.editProfileState,
    this.logoutState,
    this.resetPasswordState,
    this.userData,
    this.isResetPasswordFormValid = false,
  });

  final BaseState? getUserDataState;
  final BaseState? editProfileState;
    final UserData? userData;
  final BaseState? logoutState;
  final BaseState? resetPasswordState;
  final bool isResetPasswordFormValid;


  ProfileState copyWith({
    BaseState? getUserDataState,
    BaseState? editProfileState,
    BaseState? logoutState,
    BaseState? resetPasswordState,
    UserData? userData,
    bool? isResetPasswordFormValid,
  }) {
    return ProfileState(
      getUserDataState: getUserDataState ?? this.getUserDataState,
      editProfileState: editProfileState ?? this.editProfileState,
      logoutState: logoutState ?? this.logoutState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
      isResetPasswordFormValid:
          isResetPasswordFormValid ?? this.isResetPasswordFormValid,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [
        getUserDataState,
        editProfileState,
        logoutState,
        resetPasswordState,
        isResetPasswordFormValid,
        userData,
      ];
}
