import 'package:either_dart/either.dart';
import 'package:flower_app/features/notification/domain/entities/notification_data.dart';

abstract class NotificationRepository {
  Future<Either<Exception, List<NotificationData>>> getNotifications();
}
