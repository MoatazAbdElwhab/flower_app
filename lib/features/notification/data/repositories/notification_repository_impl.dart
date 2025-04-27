import 'package:either_dart/either.dart';
import 'package:flower_app/features/notification/data/datasources/remote/notification_reomte_data_source.dart';
import 'package:flower_app/features/notification/domain/entities/notification_data.dart';
import 'package:flower_app/features/notification/domain/repositories/notification_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  NotificationRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Exception, List<NotificationData>>> getNotifications() async {
    try {
      final notifications = await remoteDataSource.getNotifications();
      return Right(notifications.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
