import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:core/domain/usecase/usecase.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';
import 'package:data/const/string_const.dart';
import 'package:data/dao/tube_dao.dart';
import 'package:data/request/request.dart';
import 'package:data/response/response.dart';
import 'package:data/response/tube/tube_detail_response.dart';

import 'package:equatable/equatable.dart';
import 'package:data/other/failure_model.dart';
import 'package:flutter/rendering.dart';
import 'package:services/internal_service/check_connection.dart';

part 'tube_event.dart';
part 'tube_state.dart';

class TubeBloc extends Bloc<TubeEvent, TubeState> {
  final UseCase useCase;
  final SharedPref sharedPref;
  bool isFetching = false;
  int page = 1;

  TubeBloc({required this.useCase, required this.sharedPref})
      : super(TubeState.initial());

  @override
  Stream<TubeState> mapEventToState(TubeEvent event) async* {
    bool isOnline = await ConnectionStatus.hasNetwork();

    if (isOnline) {
      if (event is FetchStockTubeByStatusEvent) {
        yield* _mapFetchStockTubeByStatusToState(event);
      } else if (event is FetchTubeDetailEvent) {
        yield* _mapFetchTubeDetailToState(event);
      } else if (event is SearchStockTubeEvent) {
        yield* _mapSearchStockTubeToState(event);
      } else if (event is FetchLoadTubeEvent) {
        yield* _mapFetchLoadTubeToState(event);
      } else if (event is SearchLoadTubeEvent) {
        yield* _mapSearchLoadTubeToState(event);
      } else if (event is ScanTubeEvent) {
        yield* _mapScanTubeToState(event);
      } else if (event is GetListTubeScanEvent) {
        yield* _mapFetchListTubeScanToState();
      } else if (event is DeleteTubeEvent) {
        yield* _mapDeleteTubeToState(event);
      } else if (event is UpdateNoteTube) {
        yield* _mapUpdateNoteTubeToState(event);
      } else if (event is DeleteAllTubeEvent) {
        yield* _mapDeleteALlTubeToState();
      } else if (event is SaveDataScanTubeEvent) {
        yield* _mapSaveDataScanTubeToState(event);
      } else if (event is SaveDataScanTubeOutEvent) {
        yield* _mapSaveDataScanTubeOutToState();
      } else if (event is FetchDropdownTubeEvent) {
        yield* _mapFetchDropdownTubeToState();
      } else if (event is UpdateStockTubeEvent) {
        yield* _mapUpdateStockTubeToState(event);
      } else if (event is SaveDataScanTubeFillingStaf) {
        yield* _mapSaveDataScanTubeFillingStafToState();
      } else if (event is SaveDataScanTubeDriverStaf) {
        yield* _mapSaveDataScanTubeTakingDriverStafToState();
      } else if (event is FetchLoadTubeDriverByStatusEvent) {
        yield* _mapFetchLoadTubeDriverByStatusToState(event);
      } else if (event is SearchLoadTubeDriverEvent) {
        yield* _mapSearchLoadTubeDriverToState(event);
      } else if (event is FetchStockTubeFillingStafByStatusEvent) {
        yield* _mapFetchStockTubeFillingStafByStatusToState(event);
      } else if (event is SearchStockTubeFillingStafEvent) {
        yield* _mapSearchStockTubeFilingStafToState(event);
      } else if (event is FetchFiltersTubeEvent) {
        yield* _mapFetchFiltersToState();
      }
    } else {
      yield state.copyWith(
          status: TubeStatus.connection_error,
          failure: Failure(message: "Jaringan anda sedang bermasalah"));
    }
  }

  Stream<TubeState> _mapFetchStockTubeByStatusToState(
      FetchStockTubeByStatusEvent event) async* {
    yield state.copyWith(
        stockTube: TubeResponse(), status: TubeStatus.stock_tube_loading);

    try {
      String filterCategories = '"category": ${event.filterCategoryList}';
      String filterStatus = '"status": ${json.encode(event.filterStatusList)}';

      final tubeResponse = await useCase.getStockTubeByStatus(event.status,
          "paginate=true&page=${event.page}&perPage=${StringConst.perPageCount}&filters={$filterCategories, $filterStatus}");

      if (tubeResponse.listTube != null) {
        debugPrint("stock tube length : ${tubeResponse.listTube!.length}");
        yield state.copyWith(
            stockTube: tubeResponse, status: TubeStatus.stock_tube_loaded);

        page++;
      }
    } catch (e) {
      debugPrint("error $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapFetchTubeDetailToState(
      FetchTubeDetailEvent event) async* {
    yield state.copyWith(
        tubeDetail: TubeDetailResponse(), status: TubeStatus.loading);
    try {
      final tubeDetailResponse =
          await useCase.getTubeDetail(event.id.toString(), "");
      yield state.copyWith(
          tubeDetail: tubeDetailResponse,
          status: TubeStatus.tube_detail_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapSearchStockTubeToState(
      SearchStockTubeEvent event) async* {
    yield state.copyWith(
        searchStockTube: TubeResponse(),
        status: TubeStatus.search_stock_tube_loading);

    try {
      final searchStockTubeResponse =
          await useCase.getSearchStockTube(event.value);

      debugPrint(
          "search tube lenght : ${searchStockTubeResponse.listTube!.length}");

      yield state.copyWith(
          searchStockTube: searchStockTubeResponse,
          status: TubeStatus.search_stock_tube_loaded);
    } catch (e) {
      debugPrint("eerr $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapFetchLoadTubeToState(FetchLoadTubeEvent event) async* {
    yield state.copyWith(
        loadTube: TubeResponse(), status: TubeStatus.load_tube_loading);

    try {
      final tubeResponse = await useCase.getLoadTube(
          "paginate=true&page=${event.page}&perPage=${event.perPage}");

      debugPrint("load tube length : ${tubeResponse.listTube!.length}");

      yield state.copyWith(
          loadTube: tubeResponse, status: TubeStatus.load_tube_loaded);
    } catch (e) {
      debugPrint("error $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapSearchLoadTubeToState(
      SearchLoadTubeEvent event) async* {
    yield state.copyWith(
        searchLoadTube: TubeResponse(),
        status: TubeStatus.search_load_tube_loading);

    try {
      final searchLoadTubeResponse =
          await useCase.getSearchLoadTube(event.value);

      debugPrint(
          "search tube lenght : ${searchLoadTubeResponse.listTube!.length}");

      yield state.copyWith(
          searchLoadTube: searchLoadTubeResponse,
          status: TubeStatus.search_load_tube_loaded);
    } catch (e) {
      debugPrint("eerr $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapScanTubeToState(ScanTubeEvent event) async* {
    yield state.copyWith(
        scanTube: TubeDetailResponse(), status: TubeStatus.scan_tube_loading);
    try {
      final tubeDetailResponse =
          await useCase.getTubeDetail(event.serialNumber, "");
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
              status: TubeStatus.tube_action_loaded,
              message: "Berhasil Tambah");
        } else {
          debugPrint("Kevin gagal tambah");
          yield state.copyWith(
              status: TubeStatus.tube_action_error,
              failure: Failure(message: "Tabung sudah di scan"));
        }
      } else {
        debugPrint("data kosong");
      }

      yield state.copyWith(
          scanTube: tubeDetailResponse, status: TubeStatus.scan_tube_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapFetchListTubeScanToState() async* {
    try {
      var userId = await sharedPref.getUserId();

      final tubeResponse = await useCase.getTubeByUser(userId.toString());

      debugPrint("tube length : ${tubeResponse.length}");
      yield state.copyWith(
          tubeDao: tubeResponse, status: TubeStatus.tube_dao_loaded);
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapDeleteTubeToState(DeleteTubeEvent event) async* {
    debugPrint("hit delete");
    try {
      debugPrint("Id Product : ${event.id}");
      var userId = await sharedPref.getUserId();

      final tubeData = await useCase.getTubeByUser(userId);

      // ignore: avoid_function_literals_in_foreach_calls
      tubeData.forEach((element) {
        debugPrint("Cart ID : ${element.id}");
      });

      final deleteResponse = await useCase.deleteTube(event.id, userId);

      if (deleteResponse > 0) {
        final tubeResponse = await useCase.getTubeByUser(userId);

        yield state.copyWith(
            tubeDao: tubeResponse,
            status: TubeStatus.delete_tube_loaded,
            message: "Berhasil hapus tabung");
      } else {
        debugPrint("Gagal hapus tabung");
        yield state.copyWith(
            status: TubeStatus.error,
            failure: Failure(message: "Gagal kurang tabung"));
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapUpdateNoteTubeToState(UpdateNoteTube event) async* {
    try {
      var userId = await sharedPref.getUserId();

      final tubeResponse =
          await useCase.updateNoteTube(event.tubeId, userId, event.note);
      if (tubeResponse > 0) {
        yield state.copyWith(
            status: TubeStatus.edit_note_loaded,
            message: "Data tabung berhasil diupdate");
      } else {
        yield state.copyWith(
            status: TubeStatus.error,
            failure: Failure(message: "Gagal edit tabung"));
      }
    } catch (e) {
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapDeleteALlTubeToState() async* {
    debugPrint("hit delete all");
    try {
      final deleteResponse = await useCase.deleteAllTube();

      if (deleteResponse > 0) {
        yield state.copyWith(
            status: TubeStatus.delete_all_tube_loaded,
            message: "Berhasil hapus semua tabung");
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapSaveDataScanTubeToState(
      SaveDataScanTubeEvent event) async* {
    yield state.copyWith(
        saveDataScan: MessageResponse(),
        status: TubeStatus.save_data_scan_tube_loading);

    try {
      var userId = await sharedPref.getUserId();

      final dataScanResponse = await useCase.getTubeByUser(userId.toString());

      if (dataScanResponse.isNotEmpty) {
        List<TanksData> tubeDataRequest = [];
        for (var element in dataScanResponse) {
          tubeDataRequest.add(TanksData(
              serialNumber: element.serialNumber,
              tankCategoriesId: null,
              note: element.note));
        }

        ScanTubeRequest scanTubeRequest =
            ScanTubeRequest(tanksData: tubeDataRequest, status: event.status);

        debugPrint("List tube request : ${tubeDataRequest.length}");

        final saveDataResponse =
            await useCase.postSaveDataScanTube(scanTubeRequest);

        if (saveDataResponse.message != null) {
          debugPrint("message ${saveDataResponse.message!}");

          var resultDelete = await useCase.deleteAllTube();

          if (resultDelete > 0) {
            yield state.copyWith(
                saveDataScan: saveDataResponse,
                status: TubeStatus.save_data_scan_tube_loaded);

            yield state.copyWith(
                saveDataScan: saveDataResponse,
                status: TubeStatus.success_save_tube_in);
          } else {
            yield state.copyWith(
                status: TubeStatus.error,
                failure: Failure(message: "Gagal menyimpan data"));
          }
        }
      } else {
        yield state.copyWith(
            status: TubeStatus.error,
            failure: Failure(message: "Gagal menyimpan data"));
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapSaveDataScanTubeOutToState() async* {
    yield state.copyWith(
        saveDataScan: MessageResponse(),
        status: TubeStatus.save_data_scan_tube_loading);

    try {
      var userId = await sharedPref.getUserId();

      final dataScanResponse = await useCase.getTubeByUser(userId.toString());

      if (dataScanResponse.isNotEmpty) {
        List<TanksData> tubeDataRequest = [];
        for (var element in dataScanResponse) {
          tubeDataRequest.add(TanksData(
              serialNumber: element.serialNumber, note: element.note));
        }

        ScanTubeRequest scanTubeRequest =
            ScanTubeRequest(tanksData: tubeDataRequest);

        debugPrint("List tube request : ${tubeDataRequest.length}");

        final saveDataResponse =
            await useCase.postSaveDataScanTubeOut(scanTubeRequest);

        if (saveDataResponse.message != null) {
          debugPrint("message ${saveDataResponse.message!}");

          var resultDelete = await useCase.deleteAllTube();

          if (resultDelete > 0) {
            yield state.copyWith(
                saveDataScan: saveDataResponse,
                status: TubeStatus.save_data_scan_tube_out_loaded);
          } else {
            yield state.copyWith(
                status: TubeStatus.error,
                failure: Failure(message: "Gagal menyimpan data"));
          }
        }
      } else {
        yield state.copyWith(
            status: TubeStatus.error,
            failure: Failure(message: "Gagal menyimpan data"));
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapFetchDropdownTubeToState() async* {
    yield state.copyWith(
        dropdownTube: DropdownTubeResponse(), status: TubeStatus.loading);

    try {
      final dropdownResponse = await useCase.getDropdownTube();
      debugPrint("dropdown : ${dropdownResponse.tankCategories!.length}");
      yield state.copyWith(
          dropdownTube: dropdownResponse,
          status: TubeStatus.dropdown_driver_loaded);
    } catch (e) {
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapUpdateStockTubeToState(
      UpdateStockTubeEvent event) async* {
    yield state.copyWith(
        tubeDetail: TubeDetailResponse(),
        status: TubeStatus.update_stock_tube_loading);

    try {
      final updateStockTube =
          await useCase.putUpdateStockTube(event.requestUpdate);

      if (updateStockTube.id != null) {
        debugPrint("berhasil updated data id == ${updateStockTube.id}");
        yield state.copyWith(
            tubeDetail: updateStockTube,
            status: TubeStatus.update_stock_tube_loaded);
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapSaveDataScanTubeFillingStafToState() async* {
    yield state.copyWith(
        saveDataScan: MessageResponse(),
        status: TubeStatus.save_data_scan_tube_loading);

    try {
      var userId = await sharedPref.getUserId();
      final dataScanResponse = await useCase.getTubeByUser(userId.toString());

      if (dataScanResponse.isNotEmpty) {
        List<TanksData> tubeDataRequest = [];
        for (var element in dataScanResponse) {
          tubeDataRequest.add(
            TanksData(
              serialNumber: element.serialNumber,
              tankCategoriesId: element.tankCategoryId,
              note: element.note,
            ),
          );
        }

        ScanTubeRequest scanTubeRequest =
            ScanTubeRequest(tanksData: tubeDataRequest);

        debugPrint("List tube request : ${tubeDataRequest.length}");

        final saveDataResponse =
            await useCase.postSaveDataScanTubeFillingStaf(scanTubeRequest);

        if (saveDataResponse.message != null) {
          debugPrint("message ${saveDataResponse.message!}");

          var resultDelete = await useCase.deleteAllTube();

          if (resultDelete > 0) {
            yield state.copyWith(
                saveDataScan: saveDataResponse,
                status: TubeStatus.save_data_scan_tube_filling_loaded);
          } else {
            yield state.copyWith(
                status: TubeStatus.error,
                failure: Failure(message: "Gagal menyimpan data"));
          }
        }
      } else {
        yield state.copyWith(
            status: TubeStatus.error,
            failure: Failure(message: "Gagal menyimpan data"));
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapSaveDataScanTubeTakingDriverStafToState() async* {
    yield state.copyWith(
        saveDataScan: MessageResponse(),
        status: TubeStatus.save_data_scan_tube_loading);

    try {
      var userId = await sharedPref.getUserId();
      final dataScanResponse = await useCase.getTubeByUser(userId.toString());

      if (dataScanResponse.isNotEmpty) {
        List<TanksData> tubeDataRequest = [];
        for (var element in dataScanResponse) {
          tubeDataRequest.add(
            TanksData(
              serialNumber: element.serialNumber,
              status: element.status,
              note: element.note,
            ),
          );
        }

        ScanTubeRequest scanTubeRequest =
            ScanTubeRequest(tanksData: tubeDataRequest);

        debugPrint("List tube request : ${tubeDataRequest.length}");

        final saveDataResponse =
            await useCase.postSaveDataScanTubeTakingDriverStaf(scanTubeRequest);

        if (saveDataResponse.message != null) {
          debugPrint("message ${saveDataResponse.message!}");

          var resultDelete = await useCase.deleteAllTube();

          if (resultDelete > 0) {
            yield state.copyWith(
                saveDataScan: saveDataResponse,
                status:
                    TubeStatus.save_data_scan_tube_taking_driver_staf_loaded);
          } else {
            yield state.copyWith(
                status: TubeStatus.error,
                failure: Failure(message: "Gagal menyimpan data"));
          }
        }
      } else {
        yield state.copyWith(
            status: TubeStatus.error,
            failure: Failure(message: "Gagal menyimpan data"));
      }
    } catch (e) {
      debugPrint(e.toString());
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapFetchLoadTubeDriverByStatusToState(
      FetchLoadTubeDriverByStatusEvent event) async* {
    yield state.copyWith(
        loadTubeDriver: TubeResponse(),
        status: TubeStatus.load_tube_driver_loading);

    try {
      // &filters={"status": ["${event.status}"]}

      final tubeResponse = await useCase.getLoadTubeDriverByStatus(
          'paginate=true&page=${event.page}&perPage=${StringConst.perPageCount}&filters={"status": ["${event.status}"]}');

      debugPrint("load tube length : ${tubeResponse.listTube!.length}");
      yield state.copyWith(
          loadTubeDriver: tubeResponse,
          status: TubeStatus.load_tube_driver_loaded);
    } catch (e) {
      debugPrint("error $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapSearchLoadTubeDriverToState(
      SearchLoadTubeDriverEvent event) async* {
    yield state.copyWith(
        searchLoadTubeDriver: TubeResponse(),
        status: TubeStatus.search_load_tube_driver_loading);

    try {
      final searchLoadTubeDriver =
          await useCase.getSearchLoadTubeDriver(event.value);

      debugPrint(
          "search tube lenght : ${searchLoadTubeDriver.listTube!.length}");

      yield state.copyWith(
          searchLoadTubeDriver: searchLoadTubeDriver,
          status: TubeStatus.search_load_tube_driver_loaded);
    } catch (e) {
      debugPrint("eerr $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapFetchStockTubeFillingStafByStatusToState(
      FetchStockTubeFillingStafByStatusEvent event) async* {
    yield state.copyWith(
        stockTubeFillingStaf: TubeResponse(),
        status: TubeStatus.stock_tube_filling_staf_loading);

    try {
      var status = event.status;
      final tubeResponse = await useCase.getStockTubeFilingStaf(
          'paginate=true&page=${event.page}&perPage=${StringConst.perPageCount}&filters={"status": ["$status"]}');

      debugPrint("stock tube length : ${tubeResponse.listTube!.length}");
      yield state.copyWith(
          stockTubeFillingStaf: tubeResponse,
          status: TubeStatus.stock_tube_filling_staf_loaded);
    } catch (e) {
      debugPrint("error $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapSearchStockTubeFilingStafToState(
      SearchStockTubeFillingStafEvent event) async* {
    yield state.copyWith(
        searchStockTubeFilling: TubeResponse(),
        status: TubeStatus.search_stok_tube_filling_staf_loading);

    try {
      var searchVal = event.value;

      String status;

      var getStatus = await sharedPref.getStockTubeFillingStafStatus();

      if (getStatus == 1) {
        status = "Kosong";
      } else {
        status = "Terisi";
      }

      var filters = 'filters={"status": ["$status"]}';

      final searchLoadTubeFilling = await useCase.getStockTubeFilingStaf(
          "paginate=true&page=1&perPage=20&search=$searchVal&$filters");

      debugPrint(
          "search tube lenght : ${searchLoadTubeFilling.listTube!.length}");

      yield state.copyWith(
          searchStockTubeFilling: searchLoadTubeFilling,
          status: TubeStatus.search_stock_tube_filling_staf_loaded);
    } catch (e) {
      debugPrint("eerr $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }

  Stream<TubeState> _mapFetchFiltersToState() async* {
    yield state.copyWith(
        filtersTube: FiltersTubeResponse(),
        status: TubeStatus.filters_tube_loading);

    try {
      final filterResponse = await useCase.getFiltersTube();
      debugPrint(
          "filter tube length : ${filterResponse.listCategories!.length}");
      yield state.copyWith(
          filtersTube: filterResponse, status: TubeStatus.filters_tube_loaded);
    } catch (e) {
      debugPrint("eror get filtes tube $e");
      yield state.copyWith(
          status: TubeStatus.error, failure: Failure(message: e.toString()));
    }
  }
}
