import 'package:bloc/bloc.dart';
import 'package:core/domain/usecase/usecase.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';
import 'package:data/dao/note_dao.dart';
import 'package:data/dao/tube_dao.dart';
import 'package:data/request/request.dart';
import 'package:data/response/tube/tube_detail_response.dart';

import 'package:equatable/equatable.dart';
import 'package:data/other/failure_model.dart';
import 'package:data/response/response.dart';
import 'package:flutter/foundation.dart';
import 'package:services/internal_service/check_connection.dart';

part 'travel_doc_event.dart';
part 'travel_doc_state.dart';

class TravelDocBloc extends Bloc<TravelDocEvent, TravelDocState> {
  final UseCase useCase;
  final SharedPref sharedPref;

  TravelDocBloc({required this.useCase, required this.sharedPref})
      : super(TravelDocState.initial());

  @override
  Stream<TravelDocState> mapEventToState(TravelDocEvent event) async* {
    bool isOnline = await ConnectionStatus.hasNetwork();
    if (isOnline) {
      if (event is FetchTravelDocEvent) {
        yield* _mapFetchTravelDocToState();
      } else if (event is FetchTravelDocStatusEvent) {
        yield* _mapFetchTravelDocStatusToState(event);
      } else if (event is FetchFiltersEvent) {
        yield* _mapFetchFiltersToState();
      } else if (event is FetchTravelDocDetailEvent) {
        yield* _mapFetchTravelDocDetailToState(event);
      } else if (event is SearchTravelDocEvent) {
        yield* _mapSearchTravelDocToState(event);
      } else if (event is UpdateTravelDocEvent) {
        yield* _mapUpdateTravelDocToState(event);
      } else if (event is FetchTravelDocByFilterEvent) {
        yield* _mapFetchTravelDocByFilterToState(event);
      } else if (event is FetchDropdownDriverEvent) {
        yield* _mapFetchDropdownDriverToState();
      } else if (event is InsertNoteTravelDocEvent) {
        yield* _mapInsertNoteTravelDocToState(event);
      } else if (event is FetchNoteTravelDocEvent) {
        yield* _mapFetchNoteTravelDocToState();
      } else if (event is UpdateNoteTravelDocEvent) {
        yield* _mapUpdateNoteTravelDocToState(event);
      } else if (event is DeleteNoteTravelDocEvent) {
        yield* _mapDeleteNoteTravelDocToState();
      } else if (event is FetchListScanTubeTravelDoc) {
        yield* _mapFetchListTubeTravelDocScanToState();
      } else if (event is ScanTubeTravelDocEvent) {
        yield* _mapScanTubeTravelDocToState(event);
      } else if (event is DeleteListScanByIdTubeTravelDoc) {
        yield* _mapDeleteListScanByIdToState(event);
      } else if (event is DeleteAllListTubeTravelDoc) {
        yield* _mapDeleteALlTubeTravelDocToState();
      } else if (event is UpdateTravelDocDriverEvent) {
        yield* _mapUpdateTravelDocDriverToState(event);
      }
    } else {
      yield state.copyWith(
          status: TravelDocStatus.connection_error,
          failure: Failure(message: "Jaringan anda sedang bermasalah"));
    }
  }

  Stream<TravelDocState> _mapFetchTravelDocToState() async* {
    yield state.copyWith(
        travelDoc: TravelDocResponse(), status: TravelDocStatus.loading);

    try {
      final travelDocResponse = await useCase.getAllTravelDoc();
      debugPrint(
          "travel doc lenght : ${travelDocResponse.listTravelDoc!.length}");
      yield state.copyWith(
          travelDoc: travelDocResponse,
          status: TravelDocStatus.travel_doc_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapFetchTravelDocStatusToState(
      FetchTravelDocStatusEvent event) async* {
    yield state.copyWith(
        travelDoc: TravelDocResponse(),
        status: TravelDocStatus.travel_doc_loading);

    try {
      String? filtersData;

      if (event.filterList != null) {
        filtersData = 'filters={"tank_categories": ${event.filterList!}}';
      } else {
        filtersData = "";
      }

      debugPrint("data filter $filtersData");

      final travelDocResponse = await useCase.getTravelDocStatus(event.status,
          "paginate=true&page=${event.page!}&perPage=${event.perPage!}&$filtersData");

      debugPrint(
          "travel doc length : ${travelDocResponse.listTravelDoc!.length}");
      yield state.copyWith(
          travelDoc: travelDocResponse,
          status: TravelDocStatus.travel_doc_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapFetchFiltersToState() async* {
    yield state.copyWith(
        filters: FilterResponse(), status: TravelDocStatus.loading);

    try {
      final filterResponse = await useCase.getFilters();

      debugPrint("filter length : ${filterResponse.listFilter!.length}");
      yield state.copyWith(
          filters: filterResponse, status: TravelDocStatus.filters_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapFetchTravelDocDetailToState(
      FetchTravelDocDetailEvent event) async* {
    yield state.copyWith(
        travelDocDetail: TravelDocDetailResponse(),
        status: TravelDocStatus.loading);

    try {
      final travelDocDetail =
          await useCase.getTravelDocDetail(event.id.toString());

      if (travelDocDetail.id != null) {
        debugPrint("travel doc id ${travelDocDetail.id}");
        yield state.copyWith(
            travelDocDetail: travelDocDetail,
            status: TravelDocStatus.travel_doc_detail_loaded);
      } else {
        yield state.copyWith(
            status: TravelDocStatus.error, failure: Failure(message: "Gagal"));
      }
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapSearchTravelDocToState(
      SearchTravelDocEvent event) async* {
    yield state.copyWith(
        searchTravelDoc: TravelDocResponse(), status: TravelDocStatus.loading);

    try {
      final travelDocResponse = await useCase.getSearchTravelDoc(event.value);
      debugPrint(
          "travel doc lenght : ${travelDocResponse.listTravelDoc!.length}");
      yield state.copyWith(
          searchTravelDoc: travelDocResponse,
          status: TravelDocStatus.travel_doc_search_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapUpdateTravelDocToState(
      UpdateTravelDocEvent event) async* {
    yield state.copyWith(
        updateTravelDoc: TravelDocDetailResponse(),
        status: TravelDocStatus.update_travel_doc_loading);
    try {
      var userId = await sharedPref.getUserId();
      final dataScanResponse = await useCase.getTubeByUser(userId.toString());

      if (dataScanResponse.isNotEmpty) {
        List<TanksData> tubeDataRequest = [];
        for (var element in dataScanResponse) {
          debugPrint("Data tabung : ${element.toJson()}");
          tubeDataRequest.add(
            TanksData(
              serialNumber: element.serialNumber,
              tankCategoriesId: element.tankCategoryId,
              note: element.note,
            ),
          );
        }

        List<TankCategoryData> tankData = [];

        for (var element in event.updateTravelDocRequest.categoryId!) {
          tankData.add(
            TankCategoryData(
              tankCategoryId: element,
              tanks: tubeDataRequest
                  .where((e) => e.tankCategoriesId == element)
                  .toList(),
            ),
          );

          debugPrint("category id ${element.toString()}");
        }

        UpdateTravelDocRequest request = UpdateTravelDocRequest(
          tanksData: tankData,
          driverId: event.updateTravelDocRequest.driverId,
          vehicleId: event.updateTravelDocRequest.vehicleId,
          note: event.updateTravelDocRequest.note,
        );

        final updateTravelDocRequest =
            await useCase.patchUpdateTravelDoc(event.id.toString(), request);

        if (updateTravelDocRequest.id != null) {
          var resultDelete = await useCase.deleteAllTube();

          if (resultDelete > 0) {
            yield state.copyWith(
                updateTravelDoc: updateTravelDocRequest,
                status: TravelDocStatus.update_travel_doc_loaded);
          } else {
            debugPrint("gagal hapus list tabung");
          }
        } else {
          yield state.copyWith(
              status: TravelDocStatus.error,
              failure: Failure(message: "Gagal Update Surat Jalan"));
        }
      }
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapFetchTravelDocByFilterToState(
      FetchTravelDocByFilterEvent event) async* {
    yield state.copyWith(
        travelDocByFilters: TravelDocResponse(),
        status: TravelDocStatus.loading);

    try {
      final travelDocResponse =
          await useCase.getTravelDocByFilters(event.filterList);
      debugPrint(
          "travel doc lenght : ${travelDocResponse.listTravelDoc!.length}");
      yield state.copyWith(
          travelDocByFilters: travelDocResponse,
          status: TravelDocStatus.travel_doc_by_filters_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapFetchDropdownDriverToState() async* {
    yield state.copyWith(
        dropdownDriver: DropdownDriverResponse(),
        status: TravelDocStatus.loading);

    try {
      final dropdownResponse = await useCase.getDropdownDriver();
      debugPrint("dropdown : ${dropdownResponse.drivers!.length}");
      yield state.copyWith(
          dropdownDriver: dropdownResponse,
          status: TravelDocStatus.dropdown_driver_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapInsertNoteTravelDocToState(
      InsertNoteTravelDocEvent event) async* {
    try {
      var user = await sharedPref.getUserData();
      var nameUser = SubLoginResponse.fromJson(user);
      debugPrint("name ${nameUser.name}");
      var noteDao =
          NoteDao(id: null, desc: event.noteDao.desc, name: nameUser.name);
      final insertNoteResponse = await useCase.insertNoteTravelDoc(noteDao);
      debugPrint("berhasil tambah catatan");

      if (insertNoteResponse > 0) {
        yield state.copyWith(status: TravelDocStatus.insert_note_loaded);
      } else {
        yield state.copyWith(
            status: TravelDocStatus.error,
            failure: Failure(message: "Error Tambah nih"));
      }
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapFetchNoteTravelDocToState() async* {
    try {
      final noteDaoResponse = await useCase.getAllNoteDao();
      debugPrint("noteDao : ${noteDaoResponse.length}");
      yield state.copyWith(
          noteDao: noteDaoResponse, status: TravelDocStatus.get_note_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapUpdateNoteTravelDocToState(
      UpdateNoteTravelDocEvent event) async* {
    try {
      var user = await sharedPref.getUserData();
      var nameUser = SubLoginResponse.fromJson(user);
      debugPrint("name ${nameUser.name}");

      var noteDao = NoteDao(
          id: event.noteDao.id, desc: event.noteDao.desc, name: nameUser.name);
      final updateNoteResponse = await useCase.updateNoteTravelDoc(noteDao);

      if (updateNoteResponse > 0) {
        debugPrint("berhasil update");
        yield state.copyWith(status: TravelDocStatus.update_note_loaded);
      } else {
        yield state.copyWith(
            status: TravelDocStatus.error,
            failure: Failure(message: "Error Update"));
      }
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapDeleteNoteTravelDocToState() async* {
    try {
      await useCase.deleteNoteTravelDoc();
      yield state.copyWith(status: TravelDocStatus.delete_note_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapScanTubeTravelDocToState(
      ScanTubeTravelDocEvent event) async* {
    yield state.copyWith(
        scanTubeTravel: TubeDetailResponse(),
        status: TravelDocStatus.scan_tube_travel_loading);
    try {
      final tubeDetailResponse = await useCase.getTubeDetail(
          event.serialNumber, "?tank_category_id=${event.tankCategoryId}");
      // debugPrint("Data from api ${tubeDetailResponse.toJson()}");
      if (tubeDetailResponse.serialNumber != null) {
        var userId = await sharedPref.getUserId();
        debugPrint("userId $userId");

        var tubeDao = TubeDao.fromTubeDetailResponse(
            TubeDetailResponse.fromJson(tubeDetailResponse.toMap()));
        tubeDao.userId = userId;

        final tubeResponse = await useCase.tubeAction(tubeDao);
        debugPrint("tube $tubeDao");
        if (tubeResponse > 0) {
          debugPrint("Kevin Berhasil tambah");
          yield state.copyWith(
              status: TravelDocStatus.tube_action_loaded,
              message: "Berhasil Tambah");
        } else {
          debugPrint("Kevin gagal tambah");
          yield state.copyWith(
              status: TravelDocStatus.tube_action_error,
              failure: Failure(message: "Tabung sudah di scan"));
        }
        yield state.copyWith(
            scanTubeTravel: tubeDetailResponse,
            status: TravelDocStatus.scan_tube_travel_loaded);
      } else {
        debugPrint("Tabung tidak ditemukan");
        yield state.copyWith(
          status: TravelDocStatus.error,
          message: "Tabung tidak ditemukan",
        );
      }
    } catch (e) {
      debugPrint("error scan tabung in travel doc $e");
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapFetchListTubeTravelDocScanToState() async* {
    try {
      var userId = await sharedPref.getUserId();
      final tubeResponse = await useCase.getTubeByUser(userId.toString());
      debugPrint("tube length : ${tubeResponse.length}");
      yield state.copyWith(
          tubeDaoTravel: tubeResponse,
          status: TravelDocStatus.tube_dao_travel_loaded);
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapDeleteListScanByIdToState(
      DeleteListScanByIdTubeTravelDoc event) async* {
    try {
      debugPrint("Id tabung : ${event.id}");
      var userId = await sharedPref.getUserId();

      final tubeData = await useCase.getTubeByUser(userId);

      // ignore: avoid_function_literals_in_foreach_calls
      tubeData.forEach((element) {
        debugPrint("tabung id : ${element.id}");
      });

      final deleteResponse = await useCase.deleteTube(event.id, userId);

      if (deleteResponse > 0) {
        final tubeResponse = await useCase.getTubeByUser(userId);

        yield state.copyWith(
            tubeDaoTravel: tubeResponse,
            status: TravelDocStatus.delete_tube_travel_loaded,
            message: "Berhasil hapus tabung");
      } else {
        debugPrint("Gagal hapus tabung");
        yield state.copyWith(
            status: TravelDocStatus.error,
            failure: Failure(message: "Gagal kurang tabung"));
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapDeleteALlTubeTravelDocToState() async* {
    debugPrint("hit delete all");
    try {
      final deleteResponse = await useCase.deleteAllTube();

      if (deleteResponse > 0) {
        yield state.copyWith(
            status: TravelDocStatus.delete_all_tube_travel_loaded,
            message: "Berhasil hapus semua tabung");
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }

  Stream<TravelDocState> _mapUpdateTravelDocDriverToState(
      UpdateTravelDocDriverEvent event) async* {
    yield state.copyWith(
        updateTravelDoc: TravelDocDetailResponse(),
        status: TravelDocStatus.update_travel_doc_loading);
    try {
      var userId = await sharedPref.getUserId();
      final dataScanResponse = await useCase.getTubeByUser(userId.toString());

      if (dataScanResponse.isNotEmpty) {
        List<TanksData> tubeDataRequest = [];
        for (var element in dataScanResponse) {
          debugPrint("Data tabung : ${element.toJson()}");
          tubeDataRequest.add(
            TanksData(
              serialNumber: element.serialNumber,
              tankCategoriesId: element.tankCategoryId,
              note: element.note,
            ),
          );
        }

        List<TankCategoryData> tankData = [];

        for (var element in event.updateTravelDocRequest.categoryId!) {
          tankData.add(
            TankCategoryData(
              tankCategoryId: element,
              tanks: tubeDataRequest
                  .where((e) => e.tankCategoriesId == element)
                  .toList(),
            ),
          );

          debugPrint("category id ${element.toString()}");
        }

        UpdateTravelDocRequest request = UpdateTravelDocRequest(
          tanksData: tankData,
          recipientName: event.updateTravelDocRequest.recipientName,
          note: event.updateTravelDocRequest.note,
        );

        final updateTravelDocRequest =
            await useCase.patchUpdateTravelDoc(event.id.toString(), request);

        if (updateTravelDocRequest.id != null) {
          final sendImageRequest =
              await useCase.postSendImageTravelDoc(event.imageRequest);

          if (sendImageRequest.id != null) {
            yield state.copyWith(
                updateTravelDoc: updateTravelDocRequest,
                status: TravelDocStatus.update_travel_doc_loaded);
          } else {
            yield state.copyWith(
                status: TravelDocStatus.error,
                failure: Failure(message: "Gagal kirim gambar"));
          }
        } else {
          yield state.copyWith(
              status: TravelDocStatus.error,
              failure: Failure(message: "Gagal Update Surat Jalan"));
        }
      }
    } catch (e) {
      yield state.copyWith(
          status: TravelDocStatus.error,
          failure: Failure(message: e.toString()));
    }
  }
}
