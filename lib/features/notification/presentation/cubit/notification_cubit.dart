import 'package:equatable/equatable.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/features/notification/domain/usecases/get_notifications_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'notification_state.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  NotificationCubit({
    required this.getNotificationsUseCase,
  }) : super(const NotificationState()) {
    getNotifications();
  }

  Future<void> getNotifications() async {
    emit(state.copyWith(getNotificationsState: BaseLoadingState()));
    final result = await getNotificationsUseCase();
    result.fold(
      (error) => emit(
        state.copyWith(
          getNotificationsState: BaseErrorState(error.toString()),
        ),
      ),
      (notificationsList) => emit(
        state.copyWith(
          getNotificationsState: BaseSuccessState(
            data: notificationsList,
          ),
        ),
      ),
    );
  }
}
