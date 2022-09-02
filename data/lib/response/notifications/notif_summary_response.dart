import 'package:data/other/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notif_summary_response.g.dart';

class NotifSummaryResponse extends ResponseObject {
  @JsonKey(name: 'unread')
  int? unread;

  NotifSummaryResponse({this.unread});

  factory NotifSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$NotifSummaryResponseFromJson(json);

  static get serializer => _$NotifSummaryResponseFromJson;
}
