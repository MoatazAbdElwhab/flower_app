// features/profile/presentation/cubit/profile_state.dart
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState(
      {this.updateAddressState,
      this.deleteAddressState,
      this.getUserDataState,
      this.editProfileState,
      this.logoutState,
      this.resetPasswordState,
      this.userData,
      this.isResetPasswordFormValid = false,
      this.activeAddressid,
      this.getUserOrdersState,});

  final BaseState? getUserDataState;
  final BaseState? editProfileState;
  final BaseState? updateAddressState;
  final BaseState? deleteAddressState;
  final UserData? userData;
  final BaseState? logoutState;
  final BaseState? resetPasswordState;
  final bool isResetPasswordFormValid;
  final String? activeAddressid;
  final BaseState? getUserOrdersState;

  ProfileState copyWith(
      {BaseState? getUserDataState,
      BaseState? editProfileState,
      BaseState? updateAddressState,
      BaseState? deleteAddressState,
      BaseState? logoutState,
      BaseState? resetPasswordState,
      UserData? userData,
      bool? isResetPasswordFormValid,
      String? activeAddressId, BaseState? getUserOrdersState}) {
    return ProfileState(
        getUserDataState: getUserDataState ?? this.getUserDataState,
        editProfileState: editProfileState ?? this.editProfileState,
        updateAddressState: updateAddressState ?? this.updateAddressState,
        deleteAddressState: deleteAddressState ?? this.deleteAddressState,
        logoutState: logoutState ?? this.logoutState,
        resetPasswordState: resetPasswordState ?? this.resetPasswordState,
        isResetPasswordFormValid:
            isResetPasswordFormValid ?? this.isResetPasswordFormValid,
        userData: userData ?? this.userData,
        activeAddressid: activeAddressId,
        getUserOrdersState: getUserOrdersState ?? this.getUserOrdersState 
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
        updateAddressState,
        deleteAddressState,
        activeAddressid,
        getUserOrdersState
      ];
}
