part of 'notif_bloc.dart';

class NotifEvent extends Equatable {
  const NotifEvent();

  @override
  List<Object> get props => [];
}


class FetchNotifEvent extends NotifEvent {}

class FetchSummaryNotifEvent extends NotifEvent {}

class PostReadAllNotificationEvent extends NotifEvent {}
