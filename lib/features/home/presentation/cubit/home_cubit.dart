// features/home/presentation/cubit/home_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/error_handling/exceptions/app_exception.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/core/services/location_service.dart';
import 'package:flower_app/features/home/domain/entities/home_entity.dart';
import 'package:flower_app/features/home/domain/use_case/home_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/category_occasion_entity.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;
  final LocationService locationService;

  HomeEntity? _homeData;
  String? _locationAddress = "...................";

  HomeEntity? get homeData => _homeData;
  String? get locationAddress => _locationAddress;

  HomeCubit({
    required this.getHomeDataUseCase,
    required this.locationService,
  }) : super(HomeState(
          homeDataState: BaseInitialState(),
          locationState: BaseSuccessState(),
        ));

//-----------------------------------------------------home
  Future<void> getHomeData() async {
    emit(state.copyWith(homeDataState: BaseLoadingState()));

    final response = await getHomeDataUseCase.call();

    response.fold(
          (error) {
        Log.e('Get Home Data Error: $error');
        emit(state.copyWith(
            homeDataState: BaseErrorState(error.toString())));
      },
          (data) {
        _homeData = data;
        if (!getIt.isRegistered<List<CategoryOccasionEntity>>()) {
          getIt.registerSingleton<List<CategoryOccasionEntity>>(data.categories ?? []);
        } else {
          getIt.unregister<List<CategoryOccasionEntity>>();
          getIt.registerSingleton<List<CategoryOccasionEntity>>(data.categories ?? []);
        }

        emit(state.copyWith(homeDataState: BaseSuccessState()));
      },
    );

  }

  // -----------------------------------------------------location
  Future<void> getUserLocation() async {
    emit(state.copyWith(locationState: BaseLoadingState()));

    try {
      final position = await locationService.getCurrentPosition();
      final address = await locationService.getAddressFromCoordinates(
          position.latitude, position.longitude);

      _locationAddress = address;

      emit(state.copyWith(locationState: BaseSuccessState()));
    } catch (error) {
      Log.e('Location Error: ${error.toString()}');

      _locationAddress = "...................";

      final errorMessage =
          error is AppException ? error.message : error.toString();

      emit(state.copyWith(locationState: BaseErrorState(errorMessage)));
    }
  }
}
