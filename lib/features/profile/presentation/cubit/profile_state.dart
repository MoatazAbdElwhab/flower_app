part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState(
      {this.getUserDataState, this.editProfileState, this.logoutState});

  final BaseState? getUserDataState;
  final BaseState? editProfileState;
  final BaseState? logoutState;

  ProfileState copyWith({
    BaseState? getUserDataState,
    BaseState? editProfileState,
    BaseState? logoutState,
    UserData? userData,
  }) {
    return ProfileState(
      getUserDataState: getUserDataState ?? this.getUserDataState,
      editProfileState: editProfileState ?? this.editProfileState,
      logoutState: logoutState ?? this.logoutState,
    );
  }

  @override
  List<Object?> get props => [
        getUserDataState,
        editProfileState,
        logoutState,
      ];
}
