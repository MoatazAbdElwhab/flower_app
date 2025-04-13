part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({this.getUserDataState, this.editProfileState});

  final BaseState? getUserDataState;
  final BaseState? editProfileState;

  ProfileState copyWith({
    BaseState? getUserDataState,
    BaseState? editProfileState,
    UserData? userData,
  }) {
    return ProfileState(
      getUserDataState: getUserDataState ?? this.getUserDataState,
      editProfileState: editProfileState ?? this.editProfileState,
    );
  }

  @override
  List<Object?> get props => [getUserDataState, editProfileState,];
}
