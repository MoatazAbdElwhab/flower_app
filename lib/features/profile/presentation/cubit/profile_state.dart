part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({this.getUserDataState});

  final BaseState? getUserDataState;

  ProfileState copyWith({
    BaseState? getUserDataState,
  }) {
    return ProfileState(
      getUserDataState: getUserDataState ?? this.getUserDataState,
    );
  }

  @override
  List<Object?> get props => [getUserDataState];
}
