// ignore_for_file: constant_identifier_names

part of 'travel_doc_bloc.dart';

enum TravelDocStatus {
  initial,
  loading,
  travel_doc_loading,
  travel_doc_loaded,
  travel_doc_detail_loaded,
  travel_doc_search_loaded,
  travel_doc_update_loaded,
  travel_doc_by_filters_loaded,
  filters_loaded,
  dropdown_driver_loaded,
  insert_note_loaded,
  update_note_loaded,
  get_note_loaded,
  delete_note_loaded,
  scan_tube_travel_loading,
  scan_tube_travel_loaded,
  tube_action_loaded,
  tube_action_error,
  tube_dao_travel_loaded,
  delete_tube_travel_loaded,
  delete_all_tube_travel_loaded,
  update_travel_doc_loading,
  update_travel_doc_loaded,
  connection_error,
  error,
}

class TravelDocState extends Equatable {
  final TravelDocResponse travelDoc;
  final FilterResponse filters;
  final TravelDocDetailResponse travelDocDetail;
  final TravelDocResponse searchTravelDoc;
  final TravelDocDetailResponse updateTravelDoc;
  final TravelDocResponse travelDocByFilters;
  final DropdownDriverResponse dropdownDriver;
  final List<NoteDao> noteDao;
  final TubeDetailResponse scanTubeTravel;
  final TravelDocStatus status;
  final List<TubeDao> tubeDaoTravel;
  final Failure failure;
  final String message;
  const TravelDocState({
    required this.travelDoc,
    required this.filters,
    required this.travelDocDetail,
    required this.searchTravelDoc,
    required this.updateTravelDoc,
    required this.travelDocByFilters,
    required this.dropdownDriver,
    required this.noteDao,
    required this.scanTubeTravel,
    required this.tubeDaoTravel,
    required this.status,
    required this.failure,
    required this.message,
  });

  factory TravelDocState.initial() {
    return TravelDocState(
      travelDoc: TravelDocResponse(),
      filters: FilterResponse(),
      travelDocDetail: TravelDocDetailResponse(),
      searchTravelDoc: TravelDocResponse(),
      updateTravelDoc: TravelDocDetailResponse(),
      travelDocByFilters: TravelDocResponse(),
      dropdownDriver: DropdownDriverResponse(),
      noteDao: const [],
      scanTubeTravel: TubeDetailResponse(),
      tubeDaoTravel: const [],
      status: TravelDocStatus.initial,
      failure: Failure(),
      message: "",
    );
  }

  @override
  List<Object> get props => [
        travelDoc,
        filters,
        travelDocDetail,
        searchTravelDoc,
        updateTravelDoc,
        travelDocByFilters,
        dropdownDriver,
        noteDao,
        scanTubeTravel,
        tubeDaoTravel,
        status,
        failure,
        message,
      ];

  TravelDocState copyWith({
    TravelDocResponse? travelDoc,
    FilterResponse? filters,
    TravelDocDetailResponse? travelDocDetail,
    TravelDocResponse? searchTravelDoc,
    TravelDocDetailResponse? updateTravelDoc,
    TravelDocResponse? travelDocByFilters,
    DropdownDriverResponse? dropdownDriver,
    List<NoteDao>? noteDao,
    TubeDetailResponse? scanTubeTravel,
    List<TubeDao>? tubeDaoTravel,
    TravelDocStatus? status,
    Failure? failure,
    String? message,
  }) {
    return TravelDocState(
      travelDoc: travelDoc ?? this.travelDoc,
      filters: filters ?? this.filters,
      travelDocDetail: travelDocDetail ?? this.travelDocDetail,
      searchTravelDoc: searchTravelDoc ?? this.searchTravelDoc,
      updateTravelDoc: updateTravelDoc ?? this.updateTravelDoc,
      travelDocByFilters: travelDocByFilters ?? this.travelDocByFilters,
      dropdownDriver: dropdownDriver ?? this.dropdownDriver,
      noteDao: noteDao ?? this.noteDao,
      scanTubeTravel: scanTubeTravel ?? this.scanTubeTravel,
      status: status ?? this.status,
      tubeDaoTravel: tubeDaoTravel ?? this.tubeDaoTravel,
      failure: failure ?? this.failure,
      message: message ?? this.message,
    );
  }
}
