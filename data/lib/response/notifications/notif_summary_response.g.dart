part of 'notif_summary_response.dart';

NotifSummaryResponse _$NotifSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    NotifSummaryResponse(
        unread: json['unread'] == null ? null : json['unread'] as int);
