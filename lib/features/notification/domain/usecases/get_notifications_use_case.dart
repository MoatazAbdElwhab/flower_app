import 'package:either_dart/either.dart';
import 'package:flower_app/features/notification/domain/entities/notification_data.dart';
import 'package:flower_app/features/notification/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetNotificationsUseCase {
  final NotificationRepository repository;
  GetNotificationsUseCase({required this.repository});

  Future<Either<Exception, List<NotificationData>>> call() async =>
      await repository.getNotifications();
}
