import 'package:core/network/api_service.dart';
import 'package:core/domain/repo/remote_repository.dart';
import 'package:data/request/request.dart';
import 'package:data/response/response.dart';
import 'package:data/response/tube/tube_detail_response.dart';
import 'package:dio/dio.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  final ApiService apiService;

  RemoteRepositoryImpl({required this.apiService});

  @override
  Future<LoginResponse> postloginProcess(
      String username, String password, String role) {
    return apiService.postloginProcess(username, password, role);
  }

  @override
  Future<InfoResponse> getInfoProfile() {
    return apiService.getInfoProfile();
  }

  @override
  Future<LogoutResponse> postLogout() {
    return apiService.postLogout();
  }

  @override
  Future<AppSettingResponse> getAppSetting() {
    return apiService.getAppSetting();
  }

  @override
  Future<InfoResponse> postUpdateProfile(String name, String email,
      String username, String phone, MultipartFile avatar) {
    return apiService.postUpdateProfile(name, email, username, phone, avatar);
  }

  @override
  Future<InfoResponse> postUpdateProfileWithoutImage(
      String name, String email, String username, String phone) {
    return apiService.postUpdateProfileWithoutImage(
        name, email, username, phone);
  }

  @override
  Future<ChangePasswordResponse> postChangePassword(
      String currentPassword, String newPassword, String confirmPassword) {
    return apiService.postChangePassword(
        currentPassword, newPassword, confirmPassword);
  }

  @override
  Future<TravelDocResponse> getAllTravelDoc() {
    return apiService.getAllTravelDoc();
  }

  @override
  Future<TravelDocResponse> getTravelDocStatus(String status, String key) {
    return apiService.getTravelDocStatus(status, key);
  }

  @override
  Future<FilterResponse> getFilters() {
    return apiService.getFilters();
  }

  @override
  Future<TravelDocDetailResponse> getTravelDocDetail(String id) {
    return apiService.getTravelDocDetail(id);
  }

  @override
  Future<TravelDocResponse> getSearchTravelDoc(String value) {
    return apiService.getSearchTravelDoc(value);
  }

  @override
  Future<TravelDocResponse> getTravelDocByFilters(List filterList) {
    return apiService.getTravelDocByFilter(filterList);
  }

  @override
  Future<TubeResponse> getStockTubeByStatus(String status, String key) {
    return apiService.getStockTubeByStatus(status, key);
  }

  @override
  Future<TubeDetailResponse> getTubeDetail(String id, String key) {
    return apiService.getTubeDetail(id, key);
  }

  @override
  Future<TubeResponse> getSearchStockTube(String value) {
    return apiService.getSearchStockTube(value);
  }

  @override
  Future<TubeResponse> getLoadTube(String key) {
    return apiService.getLoadTube(key);
  }

  @override
  Future<DropdownDriverResponse> getDropdownDriver() {
    return apiService.getDropdownDriver();
  }

  @override
  Future<TubeResponse> getSearchLoadTube(String value) {
    return apiService.getSearchLoadTube(value);
  }

  @override
  Future<MessageResponse> postSaveDataScanTube(ScanTubeRequest request) {
    return apiService.postSaveDataScanTube(request);
  }

  @override
  Future<MessageResponse> postSaveDataScanTubeOut(ScanTubeRequest request) {
    return apiService.postSaveDataScanTubeOut(request);
  }

  @override
  Future<DropdownTubeResponse> getDropdownTube() {
    return apiService.getDropdownTube();
  }

  @override
  Future<TubeDetailResponse> putUpdateStockTube(UpdateTubeRequest request) {
    return apiService.putUpdateStockTube(request);
  }

  @override
  Future<MessageResponse> postSaveDataScanTubeFillingStaf(
      ScanTubeRequest request) {
    return apiService.postSaveDataScanTubeFillingStaf(request);
  }

  @override
  Future<MessageResponse> postSaveDataScanTubeTakingDriverStaf(
      ScanTubeRequest request) {
    return apiService.postSaveDataScanTakingDriverStaf(request);
  }

  @override
  Future<TubeResponse> getLoadTubeDriverByStatus(String key) {
    return apiService.getLoadTubeDriver(key);
  }

  @override
  Future<TubeResponse> getSearchLoadTubeDriver(String value) {
    return apiService.getSearchLoadTubeDriver(value);
  }

  @override
  Future<TravelDocDetailResponse> patchUpdateTravelDoc(
      String id, UpdateTravelDocRequest request) {
    return apiService.patchUpdateTravelDoc(id, request);
  }

  @override
  Future<TravelDocDetailResponse> postSendImageTravelDoc(
      AttachmentRequest attachmentRequest) {
    return apiService.postSendImageTravelDoc(attachmentRequest);
  }

  @override
  Future<TubeResponse> getStockTubeFilingStaf(String key) {
    return apiService.getStockTubeFillingStaf(key);
  }

  @override
  Future<FiltersTubeResponse> getFiltersTube() {
    return apiService.getFiltersTube();
  }

  @override
  Future<NotificationResponse> getNotification() {
    return apiService.getNotification();
  }

  @override
  Future<NotifSummaryResponse> getNotificationSummary() {
    return apiService.getNotificationSummary();
  }

  @override
  Future<MessageResponse> postReadAllNotif() {
    return apiService.postReadAllNotif();
  }
}
