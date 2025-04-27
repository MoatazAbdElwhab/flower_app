import 'package:flower_app/features/notification/data/models/notifications_response/notification.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
}
