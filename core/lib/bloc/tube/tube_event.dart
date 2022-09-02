part of 'tube_bloc.dart';

// Werehouse Staf
class TubeEvent extends Equatable {
  const TubeEvent();

  @override
  List<Object> get props => [];
}

class FetchStockTubeByStatusEvent extends TubeEvent {
  final String status;
  final int page;
  final List? filterCategoryList;
  final List<String>? filterStatusList;

  const FetchStockTubeByStatusEvent({
    required this.status,
    this.page = 1,
    this.filterCategoryList,
    this.filterStatusList,
  });

  @override
  List<Object> get props =>
      [status, page, filterCategoryList!, filterStatusList!];
}

class FetchTubeDetailEvent extends TubeEvent {
  final String id;

  const FetchTubeDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SearchStockTubeEvent extends TubeEvent {
  final String value;

  const SearchStockTubeEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class FetchLoadTubeEvent extends TubeEvent {
  final int page;
  final int perPage;
  //add this on event
  final List<SubTubeResponse> records;

  const FetchLoadTubeEvent(
      {required this.page, required this.perPage, required this.records});

  @override
  // TODO: implement props
  List<Object> get props => [page, perPage, records];
}

class SearchLoadTubeEvent extends TubeEvent {
  final String value;

  const SearchLoadTubeEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class ScanTubeEvent extends TubeEvent {
  final String serialNumber;

  const ScanTubeEvent({required this.serialNumber});

  @override
  List<Object> get props => [serialNumber];
}

class GetListTubeScanEvent extends TubeEvent {}

class DeleteTubeEvent extends TubeEvent {
  final String id;
  const DeleteTubeEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class UpdateNoteTube extends TubeEvent {
  final int tubeId;
  final String note;
  const UpdateNoteTube({
    required this.tubeId,
    required this.note,
  });

  @override
  List<Object> get props => [tubeId, note];
}

class DeleteAllTubeEvent extends TubeEvent {}

class SaveDataScanTubeEvent extends TubeEvent {
  final String status;
  const SaveDataScanTubeEvent({required this.status});

  @override
  List<Object> get props => [status];
}

class SaveDataScanTubeOutEvent extends TubeEvent {}

class FetchDropdownTubeEvent extends TubeEvent {}

class UpdateStockTubeEvent extends TubeEvent {
  final UpdateTubeRequest requestUpdate;
  const UpdateStockTubeEvent({required this.requestUpdate});

  @override
  List<Object> get props => [requestUpdate];
}

// Driver Staf
class SaveDataScanTubeDriverStaf extends TubeEvent {}

class FetchLoadTubeDriverByStatusEvent extends TubeEvent {
  final String status;
  final int page;

  const FetchLoadTubeDriverByStatusEvent({required this.status, this.page = 1});

  @override
  List<Object> get props => [status, page];
}

class SearchLoadTubeDriverEvent extends TubeEvent {
  final String value;

  const SearchLoadTubeDriverEvent({required this.value});

  @override
  List<Object> get props => [value];
}

// Filling Staf
class SaveDataScanTubeFillingStaf extends TubeEvent {}

class FetchStockTubeFillingStafByStatusEvent extends TubeEvent {
  final String status;
  final int page;

  const FetchStockTubeFillingStafByStatusEvent({required this.status, this.page = 1});

  @override
  List<Object> get props => [status, page];
}

class SearchStockTubeFillingStafEvent extends TubeEvent {
  final String value;

  const SearchStockTubeFillingStafEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class FetchFiltersTubeEvent extends TubeEvent {}
