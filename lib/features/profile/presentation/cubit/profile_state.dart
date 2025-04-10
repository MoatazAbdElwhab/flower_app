part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({this.getUserDataState, this.editProfileState, this.userData});

  final BaseState? getUserDataState;
  final BaseState? editProfileState;
  final UserData? userData;

  ProfileState copyWith({
    BaseState? getUserDataState,
    BaseState? editProfileState,
    UserData? userData,
  }) {
    return ProfileState(
      getUserDataState: getUserDataState ?? this.getUserDataState,
      editProfileState: editProfileState ?? this.editProfileState,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object?> get props => [getUserDataState, editProfileState, userData];
}
