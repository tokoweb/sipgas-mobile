import 'dart:convert';

import 'package:data/other/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_response.g.dart';

class MessageResponse extends ResponseObject {
  @JsonKey(name: 'message')
  String? message;

  MessageResponse({this.message});

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);

  Map<String, dynamic> toMap() {
    return {
      'message': message,
    };
  }

  String toJson() => json.encode(toMap());

  static get serializer => _$MessageResponseFromJson;
}
