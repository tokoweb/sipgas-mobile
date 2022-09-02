// ignore_for_file: constant_identifier_names

part of 'tube_bloc.dart';

enum TubeStatus {
  initial,
  loading,
  stock_tube_loading,
  stock_tube_loaded,
  tube_loaded,
  tube_detail_loaded,
  search_stock_tube_loading,
  search_stock_tube_loaded,
  load_tube_loading,
  load_tube_loaded,
  search_load_tube_loading,
  search_load_tube_loaded,
  scan_tube_loading,
  scan_tube_loaded,
  connection_error,
  tube_action_loaded,
  tube_action_error,
  tube_dao_loaded,
  delete_tube_loaded,
  edit_note_loaded,
  delete_all_tube_loaded,
  save_data_scan_tube_loading,
  save_data_scan_tube_loaded,
  save_data_scan_tube_out_loaded,
  success_save_tube_in,
  success_save_tube_out,
  dropdown_driver_loaded,
  update_stock_tube_loading,
  update_stock_tube_loaded,
  save_data_scan_tube_filling_loading,
  save_data_scan_tube_filling_loaded,
  save_data_scan_tube_taking_driver_staf_loaded,
  load_tube_driver_loading,
  load_tube_driver_loaded,
  search_load_tube_driver_loading,
  search_load_tube_driver_loaded,
  stock_tube_filling_staf_loading,
  stock_tube_filling_staf_loaded,
  search_stok_tube_filling_staf_loading,
  search_stock_tube_filling_staf_loaded,
  filters_tube_loading,
  filters_tube_loaded,
  error,
}

class TubeState extends Equatable {
  final TubeResponse stockTube;
  final TubeDetailResponse tubeDetail;
  final TubeResponse searchStockTube;
  final TubeResponse loadTube;
  final TubeResponse searchLoadTube;
  final TubeDetailResponse scanTube;
  final List<TubeDao> tubeDao;
  final MessageResponse saveDataScan;
  final DropdownTubeResponse dropdownTube;
  final TubeResponse loadTubeDriver;
  final TubeResponse searchLoadTubeDriver;
  final TubeResponse stockTubeFillingStaf;
  final TubeResponse searchStockTubeFilling;
  final FiltersTubeResponse filtersTube;
  final TubeStatus status;
  final Failure failure;
  final String message;
  const TubeState(
      {required this.stockTube,
      required this.tubeDetail,
      required this.searchStockTube,
      required this.loadTube,
      required this.searchLoadTube,
      required this.scanTube,
      required this.tubeDao,
      required this.saveDataScan,
      required this.dropdownTube,
      required this.loadTubeDriver,
      required this.searchLoadTubeDriver,
      required this.stockTubeFillingStaf,
      required this.searchStockTubeFilling,
      required this.filtersTube,
      required this.status,
      required this.failure,
      required this.message});

  factory TubeState.initial() {
    return TubeState(
      stockTube: TubeResponse(),
      tubeDetail: TubeDetailResponse(),
      searchStockTube: TubeResponse(),
      loadTube: TubeResponse(),
      searchLoadTube: TubeResponse(),
      scanTube: TubeDetailResponse(),
      tubeDao: const [],
      saveDataScan: MessageResponse(),
      dropdownTube: DropdownTubeResponse(),
      loadTubeDriver: TubeResponse(),
      searchLoadTubeDriver: TubeResponse(),
      stockTubeFillingStaf: TubeResponse(),
      searchStockTubeFilling: TubeResponse(),
      filtersTube: FiltersTubeResponse(),
      status: TubeStatus.initial,
      failure: Failure(),
      message: "",
    );
  }

  @override
  List<Object> get props => [
        stockTube,
        tubeDetail,
        searchStockTube,
        loadTube,
        searchLoadTube,
        scanTube,
        tubeDao,
        saveDataScan,
        dropdownTube,
        loadTubeDriver,
        searchLoadTubeDriver,
        stockTubeFillingStaf,
        searchStockTubeFilling,
        filtersTube,
        status,
        failure,
        message,
      ];

  TubeState copyWith({
    TubeResponse? stockTube,
    TubeDetailResponse? tubeDetail,
    TubeResponse? searchStockTube,
    TubeResponse? loadTube,
    TubeResponse? searchLoadTube,
    TubeDetailResponse? scanTube,
    List<TubeDao>? tubeDao,
    MessageResponse? saveDataScan,
    DropdownTubeResponse? dropdownTube,
    TubeResponse? loadTubeDriver,
    TubeResponse? searchLoadTubeDriver,
    TubeResponse? stockTubeFillingStaf,
    TubeResponse? searchStockTubeFilling,
    FiltersTubeResponse? filtersTube,
    TubeStatus? status,
    Failure? failure,
    String? message,
  }) {
    return TubeState(
        stockTube: stockTube ?? this.stockTube,
        tubeDetail: tubeDetail ?? this.tubeDetail,
        searchStockTube: searchStockTube ?? this.searchStockTube,
        loadTube: loadTube ?? this.loadTube,
        searchLoadTube: searchLoadTube ?? this.searchLoadTube,
        scanTube: scanTube ?? this.scanTube,
        tubeDao: tubeDao ?? this.tubeDao,
        saveDataScan: saveDataScan ?? this.saveDataScan,
        dropdownTube: dropdownTube ?? this.dropdownTube,
        loadTubeDriver: loadTubeDriver ?? this.loadTubeDriver,
        searchLoadTubeDriver: searchLoadTubeDriver ?? this.searchLoadTubeDriver,
        stockTubeFillingStaf: stockTubeFillingStaf ?? this.stockTubeFillingStaf,
        searchStockTubeFilling:
            searchStockTubeFilling ?? this.searchStockTubeFilling,
        filtersTube: filtersTube ?? this.filtersTube,
        status: status ?? this.status,
        failure: failure ?? this.failure,
        message: message ?? this.message);
  }
}
