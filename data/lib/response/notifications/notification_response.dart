import 'dart:convert';

import 'package:data/other/response_object.dart';
import 'package:data/response/response.dart';

part 'notification_response.g.dart';

class NotificationResponse extends ResponseObject {
  List<SubNotificationResponse>? listNotification;

  NotificationResponse({
    this.listNotification,
  });

  factory NotificationResponse.fromJson(List<dynamic> json) =>
      _$NotificationResponseFromJson(json);

  static get serializer => _$NotificationResponseFromJson;
}

class SubNotificationResponse {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  NotificationData? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  SubNotificationResponse({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'notifiable_type': notifiableType,
      'notifiable_id': notifiableId,
      'data': data,
      'read_at': readAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory SubNotificationResponse.fromMap(Map<String, dynamic> map) {
    return SubNotificationResponse(
      id: map['id'],
      type: map['type'],
      notifiableType: map['notifiable_type'],
      notifiableId: map['notifiable_id'],
      data: map['data'] != null ? NotificationData.fromMap(map['data']) : null,
      readAt: map['read_at'] ?? '',
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SubNotificationResponse.fromJson(String source) =>
      SubNotificationResponse.fromMap(json.decode(source));
}

class NotificationData {
  String type;
  Data? data;
  String actionUrl;

  NotificationData({
    required this.type,
    required this.data,
    required this.actionUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'data': data,
      'action_url': actionUrl,
    };
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      type: map['type'],
      data: map['data'] != null ? Data.fromMap(map['data']) : null,
      actionUrl: map['action_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));
}

class Data {
  int? id;
  String? from;
  String? to;
  int? deposit;
  int? deliveryId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? statusLabel;
  CustomerData? customerData;

  Data({
    this.id,
    this.from,
    this.to,
    this.deposit,
    this.deliveryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.statusLabel,
    this.customerData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'from': from,
      'to': to,
      'deposit': deposit,
      'delivery_id': deliveryId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status_label': statusLabel,
      'customer': customerData,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'],
      from: map['from'],
      to: map['to'],
      deposit: map['deposit'],
      deliveryId: map['deliveryId'] ?? 0,
      customerData: map['customer'] != null
          ? CustomerData.fromMap(map['customer'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));
}
