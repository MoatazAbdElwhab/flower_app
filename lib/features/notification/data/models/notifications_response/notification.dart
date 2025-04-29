import 'package:flower_app/features/notification/domain/entities/notification_data.dart';

class NotificationModel {
  final String? id;
  final String? title;
  final String? body;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const NotificationModel({
    this.id,
    this.title,
    this.body,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['_id'] as String?,
        title: json['title'] as String?,
        body: json['body'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'body': body,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };

  NotificationData toEntity() => NotificationData(
        id: id ?? '',
        title: title ?? '',
        body: body ?? '',
      );
}
