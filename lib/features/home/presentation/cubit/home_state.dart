// features/home/presentation/cubit/home_state.dart
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final BaseState homeDataState;
  final BaseState locationState;

  const HomeState({
    required this.homeDataState,
    required this.locationState,
  });

  HomeState copyWith({
    BaseState? homeDataState,
    BaseState? locationState,
  }) {
    return HomeState(
      homeDataState: homeDataState ?? this.homeDataState,
      locationState: locationState ?? this.locationState,
    );
  }

  @override
  List<Object?> get props => [homeDataState, locationState];
}
