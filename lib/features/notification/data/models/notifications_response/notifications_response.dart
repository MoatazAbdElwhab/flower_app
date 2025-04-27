import 'package:flower_app/features/notification/data/models/notifications_response/metadata.dart';
import 'package:flower_app/features/notification/data/models/notifications_response/notification.dart';

class NotificationsResponse {
  final String? message;
  final Metadata? metadata;
  final List<NotificationModel>? notifications;

  const NotificationsResponse({
    this.message,
    this.metadata,
    this.notifications,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'metadata': metadata?.toJson(),
        'notifications': notifications?.map((e) => e.toJson()).toList(),
      };
}
