part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({this.getNotificationsState});

  final BaseState? getNotificationsState;

  NotificationState copyWith({
    BaseState? getNotificationsState,
  }) {
    return NotificationState(
      getNotificationsState:
          getNotificationsState ?? this.getNotificationsState,
    );
  }

  @override
  List<Object?> get props => [getNotificationsState];
}
