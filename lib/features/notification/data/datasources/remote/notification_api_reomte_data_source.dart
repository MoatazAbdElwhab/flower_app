import 'package:flower_app/core/app_data/api/api_client.dart';
import 'package:flower_app/core/app_data/api/api_constants.dart';
import 'package:flower_app/features/notification/data/datasources/remote/notification_reomte_data_source.dart';
import 'package:flower_app/features/notification/data/models/notifications_response/notification.dart';
import 'package:flower_app/features/notification/data/models/notifications_response/notifications_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationRemoteDataSource)
class NotificationApiRemoteDataSource extends NotificationRemoteDataSource {
  final ApiClient apiClient;
  NotificationApiRemoteDataSource({required this.apiClient});
  @override
  Future<List<NotificationModel>> getNotifications() async {
    final response = await apiClient.get(
      ApiConstants.notificationsEndPoint,
      requiresToken: true,
    );
    return NotificationsResponse.fromJson(response).notifications ?? [];
  }
}
