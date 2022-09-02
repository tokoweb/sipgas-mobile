part of 'message_response.dart';

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) =>
    MessageResponse(
      message: json['message'] == null ? null : json['message'] as String,
    );
