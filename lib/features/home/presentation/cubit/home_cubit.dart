// features/home/presentation/cubit/home_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/core/services/location_service.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flower_app/features/home/domain/use_case/home_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;
  final LocationService locationService;

  HomeCubit({
    required this.getHomeDataUseCase,
    required this.locationService,
  }) : super(HomeState(
          homeDataState: BaseInitialState(),
          locationState: BaseSuccessState(),
          locationAddress: "...................",
        ));

//-----------------------------------------------------home
  Future<void> getHomeData() async {
    try {
      emit(state.copyWith(homeDataState: BaseLoadingState()));

      final response = await getHomeDataUseCase.call();

      if (response.isLeft) {
        emit(state.copyWith(
            homeDataState: BaseErrorState(response.left.toString())));
        return;
      }

      emit(state.copyWith(
        homeDataState: BaseSuccessState(),
        homeData: response.right,
      ));
    } catch (e) {
      Log.e('Get Home Data Error: ${e.toString()}');
      emit(state.copyWith(homeDataState: BaseErrorState(e.toString())));
    }
  }

  //-----------------------------------------------------location
  Future<void> getUserLocation() async {
    try {
      emit(state.copyWith(locationState: BaseLoadingState()));

      final position = await locationService.getCurrentPosition();
      final address = await locationService.getAddressFromCoordinates(
          position.latitude, position.longitude);

      emit(state.copyWith(
        locationState: BaseSuccessState(),
        locationAddress: address,
      ));
    } catch (error) {
      Log.e('Get Location Error: ${error.toString()}');
      emit(state.copyWith(
        locationState: BaseSuccessState(),
        locationAddress: "...................",
      ));
    }
  }
}
