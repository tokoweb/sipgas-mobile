import 'package:core/bloc/bloc.dart';
import 'package:core/domain/repo/local_repository.dart';
import 'package:core/domain/repo/remote_repository.dart';
import 'package:data/dao/note_dao.dart';
import 'package:data/dao/tube_dao.dart';
import 'package:data/request/request.dart';
import 'package:data/response/response.dart';
import 'package:data/response/tube/tube_detail_response.dart';
import 'package:dio/dio.dart' as dio;

class UseCase {
  final RemoteRepository repository;
  final LocalRepository localRepository;

  UseCase({required this.repository, required this.localRepository});

  // Auth
  Future<LoginResponse> postloginProcess(
      String username, String password, String role) {
    return repository.postloginProcess(username, password, role);
  }

  Future<InfoResponse> getInfoProfile() {
    return repository.getInfoProfile();
  }

  Future<LogoutResponse> postLogout() {
    return repository.postLogout();
  }

  Future<InfoResponse> postUpdateProfile(String name, String email,
      String username, String phone, dio.MultipartFile avatar) {
    return repository.postUpdateProfile(name, email, username, phone, avatar);
  }

  Future<InfoResponse> postUpdateProfileWithoutImage(
      String name, String email, String username, String phone) {
    return repository.postUpdateProfileWithoutImage(
        name, email, username, phone);
  }

  Future<ChangePasswordResponse> postChangePassword(
      String currentPassword, String newPassword, String confirmPassword) {
    return repository.postChangePassword(
        currentPassword, newPassword, confirmPassword);
  }

  // App Setting
  Future<AppSettingResponse> getAppSetting() {
    return repository.getAppSetting();
  }

  // Travel Doc
  Future<TravelDocResponse> getAllTravelDoc() {
    return repository.getAllTravelDoc();
  }

  Future<TravelDocResponse> getTravelDocStatus(String status, String key) {
    return repository.getTravelDocStatus(status, key);
  }

  Future<FilterResponse> getFilters() {
    return repository.getFilters();
  }

  Future<TravelDocDetailResponse> getTravelDocDetail(String id) {
    return repository.getTravelDocDetail(id);
  }

  Future<TravelDocResponse> getSearchTravelDoc(String value) {
    return repository.getSearchTravelDoc(value);
  }

  Future<TravelDocResponse> getTravelDocByFilters(List filterList) {
    return repository.getTravelDocByFilters(filterList);
  }

  Future<DropdownDriverResponse> getDropdownDriver() {
    return repository.getDropdownDriver();
  }

  Future<int> insertNoteTravelDoc(NoteDao noteDao) {
    return localRepository.insertNoteTravelDoc(noteDao);
  }

  Future<List<NoteDao>> getAllNoteDao() {
    return localRepository.getAllNoteDao();
  }

  Future<int> updateNoteTravelDoc(NoteDao noteDao) {
    return localRepository.updateNoteTravelDoc(noteDao);
  }

  Future<int> deleteNoteTravelDoc() {
    return localRepository.deleteNoteTravelDoc();
  }

  Future<TravelDocDetailResponse> patchUpdateTravelDoc(
      String id, UpdateTravelDocRequest request) {
    return repository.patchUpdateTravelDoc(id, request);
  }

  Future<TravelDocDetailResponse> postSendImageTravelDoc(
      AttachmentRequest attachmentRequest) {
    return repository.postSendImageTravelDoc(attachmentRequest);
  }

  // Tube
  Future<TubeResponse> getStockTubeByStatus(String status, String key) {
    return repository.getStockTubeByStatus(status, key);
  }

  Future<TubeDetailResponse> getTubeDetail(String id, String key) {
    return repository.getTubeDetail(id, key);
  }

  Future<TubeResponse> getSearchStockTube(String value) {
    return repository.getSearchStockTube(value);
  }

  Future<TubeResponse> getLoadTube(String key) {
    return repository.getLoadTube(key);
  }

  Future<TubeResponse> getSearchLoadTube(String value) {
    return repository.getSearchLoadTube(value);
  }

  Future<int> tubeAction(TubeDao product) {
    return localRepository.tubeAction(product);
  }

  Future<List<TubeDao>> getTubeByUser(String userId) {
    return localRepository.getTubeByUser(userId);
  }

  Future<int> deleteTube(String id, String userId) {
    return localRepository.deleteTube(id, userId);
  }

  Future<int> updateNoteTube(int tubeId, String userId, String note) {
    return localRepository.updateNoteTube(tubeId, userId, note);
  }

  Future<int> deleteAllTube() {
    return localRepository.deleteAllTube();
  }

  Future<MessageResponse> postSaveDataScanTube(ScanTubeRequest request) {
    return repository.postSaveDataScanTube(request);
  }

  Future<MessageResponse> postSaveDataScanTubeOut(ScanTubeRequest request) {
    return repository.postSaveDataScanTubeOut(request);
  }

  Future<DropdownTubeResponse> getDropdownTube() {
    return repository.getDropdownTube();
  }

  Future<TubeDetailResponse> putUpdateStockTube(UpdateTubeRequest req) {
    return repository.putUpdateStockTube(req);
  }

  Future<FiltersTubeResponse> getFiltersTube() {
    return repository.getFiltersTube();
  }

  // Tube Filling Staff
  Future<MessageResponse> postSaveDataScanTubeFillingStaf(
      ScanTubeRequest request) {
    return repository.postSaveDataScanTubeFillingStaf(request);
  }

  // Tube Driver Staf
  Future<MessageResponse> postSaveDataScanTubeTakingDriverStaf(
      ScanTubeRequest request) {
    return repository.postSaveDataScanTubeTakingDriverStaf(request);
  }

  Future<TubeResponse> getLoadTubeDriverByStatus(String key) {
    return repository.getLoadTubeDriverByStatus(key);
  }

  Future<TubeResponse> getSearchLoadTubeDriver(String key) {
    return repository.getSearchLoadTubeDriver(key);
  }

  // Tube Filling Staf
  Future<TubeResponse> getStockTubeFilingStaf(String key) {
    return repository.getStockTubeFilingStaf(key);
  }

  // Notification
  Future<NotificationResponse> getNotification() {
    return repository.getNotification();
  }

  Future<NotifSummaryResponse> getNotificationSummary() {
    return repository.getNotificationSummary();
  }

   Future<MessageResponse> postReadAllNotif() {
    return repository.postReadAllNotif();
  }
}
