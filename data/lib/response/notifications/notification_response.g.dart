part of 'notification_response.dart';

NotificationResponse _$NotificationResponseFromJson(List<dynamic> data) =>
    NotificationResponse(
        listNotification: data
            .map((e) => SubNotificationResponse.fromMap(e as Map<String, dynamic>))
            .toList());
