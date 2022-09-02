import 'package:json_annotation/json_annotation.dart';

import '../../other/response_object.dart';

part 'logout_response.g.dart';

@JsonSerializable(createToJson: false)
class LogoutResponse extends ResponseObject {
  @JsonKey(name: 'message')
  String? message;

  LogoutResponse({
    this.message,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseFromJson(json);

  static get serializer => _$LogoutResponseFromJson;
}
