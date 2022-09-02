part of 'travel_doc_bloc.dart';

class TravelDocEvent extends Equatable {
  const TravelDocEvent();

  @override
  List<Object> get props => [];
}

class FetchTravelDocEvent extends TravelDocEvent {}

class FetchTravelDocStatusEvent extends TravelDocEvent {
  final String status;
  final int? page;
  final int? perPage;
  //add this on event
  final List<SubTravelDocResponse>? records;
  final List? filterList;

  const FetchTravelDocStatusEvent(
      {required this.status,
      this.page,
      this.perPage,
      this.records,
      this.filterList});

  @override
  List<Object> get props => [status, page!, perPage!, records!, filterList!];
}

class FetchTravelDocDetailEvent extends TravelDocEvent {
  final String id;

  const FetchTravelDocDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class FetchFiltersEvent extends TravelDocEvent {}

class SearchTravelDocEvent extends TravelDocEvent {
  final String value;

  const SearchTravelDocEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class UpdateTravelDocEvent extends TravelDocEvent {
  final String id;
  final UpdateTravelDocRequest updateTravelDocRequest;

  const UpdateTravelDocEvent(
      {required this.id, required this.updateTravelDocRequest});

  @override
  // TODO: implement props
  List<Object> get props => [id, updateTravelDocRequest];
}

class FetchTravelDocByFilterEvent extends TravelDocEvent {
  final List filterList;

  const FetchTravelDocByFilterEvent({required this.filterList});

  @override
  List<Object> get props => [filterList];
}

class FetchDropdownDriverEvent extends TravelDocEvent {}

class InsertNoteTravelDocEvent extends TravelDocEvent {
  final NoteDao noteDao;

  const InsertNoteTravelDocEvent({required this.noteDao});

  @override
  List<Object> get props => [noteDao];
}

class FetchNoteTravelDocEvent extends TravelDocEvent {}

class UpdateNoteTravelDocEvent extends TravelDocEvent {
  final NoteDao noteDao;

  const UpdateNoteTravelDocEvent({required this.noteDao});

  @override
  List<Object> get props => [noteDao];
}

class DeleteNoteTravelDocEvent extends TravelDocEvent {}

class ScanTubeTravelDocEvent extends TravelDocEvent {
  final String serialNumber;
  final String tankCategoryId;

  const ScanTubeTravelDocEvent(
      {required this.serialNumber, required this.tankCategoryId});

  @override
  List<Object> get props => [serialNumber, tankCategoryId];
}

class FetchListScanTubeTravelDoc extends TravelDocEvent {}

class DeleteListScanByIdTubeTravelDoc extends TravelDocEvent {
  final String id;
  const DeleteListScanByIdTubeTravelDoc({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class DeleteAllListTubeTravelDoc extends TravelDocEvent {}

class UpdateTravelDocDriverEvent extends TravelDocEvent {
  final String id;
  final UpdateTravelDocRequest updateTravelDocRequest;
  final AttachmentRequest imageRequest;

  const UpdateTravelDocDriverEvent(
      {required this.id,
      required this.updateTravelDocRequest,
      required this.imageRequest});

  @override
  List<Object> get props => [id, updateTravelDocRequest, imageRequest];
}
