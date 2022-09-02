import 'package:data/request/request.dart';
import 'package:data/response/response.dart';
import 'package:data/response/tube/tube_detail_response.dart';
import 'package:dio/dio.dart' as dio;

abstract class RemoteRepository {
  // Auth
  Future<LoginResponse> postloginProcess(
      String username, String password, String role);
  Future<InfoResponse> getInfoProfile();
  Future<LogoutResponse> postLogout();
  Future<InfoResponse> postUpdateProfile(String name, String email,
      String username, String phone, dio.MultipartFile avatar);
  Future<InfoResponse> postUpdateProfileWithoutImage(
      String name, String email, String username, String phone);
  Future<ChangePasswordResponse> postChangePassword(
      String currentPassword, String newPassword, String confirmPassword);

  // App Setting
  Future<AppSettingResponse> getAppSetting();

  // Travel Doc
  Future<TravelDocResponse> getAllTravelDoc();
  Future<TravelDocResponse> getTravelDocStatus(String status, String key);
  Future<FilterResponse> getFilters();
  Future<TravelDocDetailResponse> getTravelDocDetail(String id);
  Future<TravelDocResponse> getSearchTravelDoc(String value);
  Future<TravelDocResponse> getTravelDocByFilters(List filterList);
  Future<DropdownDriverResponse> getDropdownDriver();
  Future<TravelDocDetailResponse> patchUpdateTravelDoc(
      String id, UpdateTravelDocRequest request);

  Future<TravelDocDetailResponse> postSendImageTravelDoc(
      AttachmentRequest attachmentRequest);

  // Tube
  Future<TubeResponse> getStockTubeByStatus(String status, String key);
  Future<TubeDetailResponse> getTubeDetail(String id, String key);
  Future<TubeResponse> getSearchStockTube(String value);
  Future<TubeResponse> getLoadTube(String key);
  Future<TubeResponse> getSearchLoadTube(String value);
  Future<MessageResponse> postSaveDataScanTube(ScanTubeRequest request);
  Future<MessageResponse> postSaveDataScanTubeOut(ScanTubeRequest request);
  Future<DropdownTubeResponse> getDropdownTube();
  Future<TubeDetailResponse> putUpdateStockTube(UpdateTubeRequest request);
  Future<FiltersTubeResponse> getFiltersTube();

  // Tube Filling staff
  Future<MessageResponse> postSaveDataScanTubeFillingStaf(
      ScanTubeRequest request);

  // Tube Driver staff
  Future<MessageResponse> postSaveDataScanTubeTakingDriverStaf(
      ScanTubeRequest request);
  Future<TubeResponse> getLoadTubeDriverByStatus(String key);
  Future<TubeResponse> getSearchLoadTubeDriver(String value);

  // Tube Filling staf
  Future<TubeResponse> getStockTubeFilingStaf(String key);

  // notification
  Future<NotificationResponse> getNotification();
  Future<NotifSummaryResponse> getNotificationSummary();
  Future<MessageResponse> postReadAllNotif();
}
