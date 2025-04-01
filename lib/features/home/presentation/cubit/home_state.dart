// features/home/presentation/cubit/home_state.dart
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final BaseState homeDataState;
  final HomeEntity? homeData;
  final BaseState locationState;
  final String? locationAddress;

  const HomeState({
    required this.homeDataState,
    this.homeData,
    required this.locationState,
    this.locationAddress,
  });

  HomeState copyWith({
    BaseState? homeDataState,
    HomeEntity? homeData,
    BaseState? locationState,
    String? locationAddress,
  }) {
    return HomeState(
      homeDataState: homeDataState ?? this.homeDataState,
      homeData: homeData ?? this.homeData,
      locationState: locationState ?? this.locationState,
      locationAddress: locationAddress ?? this.locationAddress,
    );
  }

  @override
  List<Object?> get props => [homeDataState, homeData, locationState, locationAddress];
}
