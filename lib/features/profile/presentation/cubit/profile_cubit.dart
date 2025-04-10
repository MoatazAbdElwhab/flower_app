import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetUserDataUseCase _getUserDataUseCase;
  ProfileCubit(this._getUserDataUseCase) : super(const ProfileState()) {
    getUserData();
  }

  final ValueNotifier<bool> isNotificationEnabled = ValueNotifier(false);

  Future<void> getUserData() async {
    emit(state.copyWith(getUserDataState: BaseLoadingState()));
    final result = await _getUserDataUseCase();
    result.fold(
      (error) => emit(
        state.copyWith(
          getUserDataState: BaseErrorState(error.toString()),
        ),
      ),
      (data) => emit(
        state.copyWith(
          getUserDataState: BaseSuccessState(data: data),
        ),
      ),
    );
  }

  void changeNotification() {
    isNotificationEnabled.value = !isNotificationEnabled.value;
  }
}
