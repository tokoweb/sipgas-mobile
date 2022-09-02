// ignore_for_file: constant_identifier_names

part of 'notif_bloc.dart';

enum NotifStatus {
  initial,
  loading,
  fetch_loaded,
  summary_loaded,
  read_all_loading,
  read_all_loaded,
  error,
}

class NotifState extends Equatable {
  final NotificationResponse notif;
  final NotifSummaryResponse summaryNotif;
  final MessageResponse readAll;
  final NotifStatus status;
  final Failure failure;
  const NotifState(
      {required this.notif,
      required this.summaryNotif,
      required this.readAll,
      required this.status,
      required this.failure});

  factory NotifState.initial() {
    return NotifState(
      notif: NotificationResponse(),
      summaryNotif: NotifSummaryResponse(),
      readAll: MessageResponse(),
      status: NotifStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object> get props => [notif, summaryNotif, readAll, status, failure];

  NotifState copyWith({
    NotificationResponse? notif,
    NotifSummaryResponse? summaryNotif,
    MessageResponse? readAll,
    NotifStatus? status,
    Failure? failure,
  }) {
    return NotifState(
      notif: notif ?? this.notif,
      summaryNotif: summaryNotif ?? this.summaryNotif,
      readAll: readAll ?? this.readAll,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
