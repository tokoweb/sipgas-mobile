import 'package:bloc/bloc.dart';
import 'package:core/domain/usecase/usecase.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';

import 'package:equatable/equatable.dart';
import 'package:data/other/failure_model.dart';
import 'package:data/response/response.dart';
import 'package:flutter/foundation.dart';

part 'notif_event.dart';
part 'notif_state.dart';

class NotifBloc extends Bloc<NotifEvent, NotifState> {
  final UseCase useCase;
  final SharedPref sharedPref;
  NotifBloc({required this.useCase, required this.sharedPref})
      : super(NotifState.initial());

  @override
  Stream<NotifState> mapEventToState(NotifEvent event) async* {
    if (event is FetchNotifEvent) {
      yield* _mapFetchNotifToState();
    } else if (event is FetchSummaryNotifEvent) {
      yield* _mapFetchSummaryNotifToState();
    } else if (event is PostReadAllNotificationEvent) {
      yield* _mapReadAllNotifToState();
    }
  }

  Stream<NotifState> _mapFetchNotifToState() async* {
    yield state.copyWith(
        notif: NotificationResponse(), status: NotifStatus.loading);
    try {
      final notifResponse = await useCase.getNotification();

      debugPrint("notif response ${notifResponse.listNotification!.length}");

      yield state.copyWith(
          notif: notifResponse, status: NotifStatus.fetch_loaded);
    } catch (e) {
      debugPrint("error fetch notif $e");
      yield state.copyWith(
          status: NotifStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<NotifState> _mapFetchSummaryNotifToState() async* {
    yield state.copyWith(
        summaryNotif: NotifSummaryResponse(), status: NotifStatus.loading);
    try {
      final summaryResponse = await useCase.getNotificationSummary();

      debugPrint("Notif Summary count ${summaryResponse.unread}");
      yield state.copyWith(
          summaryNotif: summaryResponse, status: NotifStatus.summary_loaded);
    } catch (e) {
      debugPrint("error summary notif $e");
      yield state.copyWith(
          status: NotifStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<NotifState> _mapReadAllNotifToState() async* {
    yield state.copyWith(
        readAll: MessageResponse(), status: NotifStatus.loading);
    try {
      final notifResponse = await useCase.postReadAllNotif();

      debugPrint("message ${notifResponse.message!}");

      yield state.copyWith(
          readAll: notifResponse, status: NotifStatus.read_all_loaded);
    } catch (e) {
      debugPrint("error read all notif $e");
      yield state.copyWith(
          status: NotifStatus.error, failure: Failure(message: e.toString()));
    }
  }
}
