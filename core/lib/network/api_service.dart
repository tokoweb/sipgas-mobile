import 'package:core/network/api_constant.dart';
import 'package:core/repository/local/shared/shared_preferences.dart';
import 'package:data/const/string_const.dart';
import 'package:data/other/handle_failure.dart';
import 'package:data/other/response_object.dart';
import 'package:data/other/tupple.dart';
import 'package:data/request/request.dart';
import 'package:data/response/response.dart';
import 'package:data/response/tube/tube_detail_response.dart';
import 'package:services/internal_service/get_data_api.dart';
import 'package:data/other/config_environment.dart';
import 'package:dio/dio.dart';

class ApiService extends ConfigEnvironment with GetDataApi {
  final Dio dio;
  final SharedPref sharedPref;
  ApiService({required this.dio, required this.sharedPref});

  Future<LoginResponse> postloginProcess(
      String username, String password, String role) async {
    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
            baseUrl: ApiConstant.baseUrlDev + ApiConstant.loginUrl,
            headers: {
              "Accept": "application/json",
            },
            endPoint: "",
            nullSafety: {},
            serializer: LoginResponse.serializer,
            bodyObject: LoginRequest(
              username: username,
              password: password,
              role: role,
            ).toMap());

    LoginResponse dataResult = data.onSuccess as LoginResponse;

    return dataResult;
  }

  Future<InfoResponse> getInfoProfile() async {
    var token = await sharedPref.getTokenUser();
    print("token : " + token);

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.infoUrl,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: InfoResponse.serializer,
    );

    InfoResponse dataResult = data.onSuccess as InfoResponse;

    return dataResult;
  }

  Future<LogoutResponse> postLogout() async {
    var token = await sharedPref.getTokenUser();
    print("token : " + token);
    Tupple<HandleFailure, ResponseObject> data = await postdataAPIHeadersBody(
        baseUrl: ApiConstant.baseUrlDev + ApiConstant.logoutUrl,
        headers: {
          "Accept": "application/json",
          "AUTHORIZATION": 'Bearer ' + token,
        },
        endPoint: "",
        nullSafety: {},
        serializer: LogoutResponse.serializer,
        bodyObject: {});

    LogoutResponse dataResult = data.onSuccess as LogoutResponse;

    return dataResult;
  }

  Future<AppSettingResponse> getAppSetting() async {
    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.settingUrl,
      headers: {
        // "Accept": "application/json",
        // "AUTHORIZATION": '${StringConst.basicAuth}',
      },
      endPoint: "",
      nullSafety: {},
      serializer: AppSettingResponse.serializer,
    );

    AppSettingResponse dataResult = data.onSuccess as AppSettingResponse;

    return dataResult;
  }

  Future<InfoResponse> postUpdateProfile(String name, String email,
      String username, String phone, MultipartFile avatar) async {
    var token = await sharedPref.getTokenUser();

    print("Token : $token");
    // String fileName = avatar.path.split('/').last;

    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
            baseUrl: ApiConstant.baseUrlDev + ApiConstant.updateProfileUrl,
            headers: {
              "Accept": "application/json",
              "AUTHORIZATION": 'Bearer ' + token,
            },
            endPoint: "",
            nullSafety: {},
            serializer: InfoResponse.serializer,
            bodyObject: UpdateProfileRequest(
              name: name,
              email: email,
              username: username,
              phone: phone,
              avatar: avatar,
            ).toMap());

    InfoResponse dataResult = data.onSuccess as InfoResponse;

    return dataResult;
  }

  Future<InfoResponse> postUpdateProfileWithoutImage(
      String name, String email, String username, String phone) async {
    var token = await sharedPref.getTokenUser();

    print("Token : $token");
    // String fileName = avatar.path.split('/').last;

    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
            baseUrl: ApiConstant.baseUrlDev + ApiConstant.updateProfileUrl,
            headers: {
              "Accept": "application/json",
              "AUTHORIZATION": 'Bearer ' + token,
            },
            endPoint: "",
            nullSafety: {},
            serializer: InfoResponse.serializer,
            bodyObject: UpdateProfileRequest(
              name: name,
              email: email,
              username: username,
              phone: phone,
              avatar: null,
            ).toMap());

    InfoResponse dataResult = data.onSuccess as InfoResponse;

    return dataResult;
  }

  Future<ChangePasswordResponse> postChangePassword(String currentPassword,
      String newPassword, String confirmPassword) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
            baseUrl: ApiConstant.baseUrlDev + ApiConstant.changePasswordUrl,
            headers: {
              "Accept": "application/json",
              "AUTHORIZATION": 'Bearer ' + token,
            },
            endPoint: "",
            nullSafety: {},
            serializer: ChangePasswordResponse.serializer,
            bodyObject: ChangePasswordRequest(
                    currentPassword: currentPassword,
                    newPassword: newPassword,
                    confirmPassword: confirmPassword)
                .toMap());

    ChangePasswordResponse dataResult =
        data.onSuccess as ChangePasswordResponse;

    return dataResult;
  }

  Future<TravelDocResponse> getAllTravelDoc() async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.travelDocUrl +
          "?paginate=true&page=1&perPage=20" +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TravelDocResponse.serializer,
    );

    TravelDocResponse dataResult = data.onSuccess as TravelDocResponse;

    return dataResult;
  }

  Future<TravelDocResponse> getTravelDocStatus(
      String status, String key) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.travelDocUrl +
          "/$status" +
          "?$key" +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TravelDocResponse.serializer,
    );

    TravelDocResponse dataResult = data.onSuccess as TravelDocResponse;

    return dataResult;
  }

  Future<TravelDocResponse> getTravelDocByFilter(List filterList) async {
    var token = await sharedPref.getTokenUser();
    var status = await sharedPref.getTravelDocStatus();
    String statusConvert;

    if (status == 0) {
      statusConvert = "progress";
    } else {
      statusConvert = "done";
    }

    print("status travel doc $statusConvert");

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.travelDocUrl +
          "/$statusConvert" +
          '?filters={"tank_categories": $filterList}' +
          "&paginate=true&page=1&perPage=20" +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TravelDocResponse.serializer,
    );

    TravelDocResponse dataResult = data.onSuccess as TravelDocResponse;

    return dataResult;
  }

  Future<FilterResponse> getFilters() async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.filtersUrl,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: FilterResponse.serializer,
    );

    FilterResponse dataResult = data.onSuccess as FilterResponse;

    return dataResult;
  }

  Future<TravelDocDetailResponse> getTravelDocDetail(String id) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.travelDocUrl + "/$id",
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TravelDocDetailResponse.serializer,
    );

    TravelDocDetailResponse dataResult =
        data.onSuccess as TravelDocDetailResponse;

    return dataResult;
  }

  Future<TravelDocResponse> getSearchTravelDoc(String search) async {
    var token = await sharedPref.getTokenUser();

    var status = await sharedPref.getTravelDocStatus();
    String statusConvert;

    if (status == 0) {
      statusConvert = "progress";
    } else {
      statusConvert = "done";
    }

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.travelDocUrl +
          "/$statusConvert" +
          "?search=$search" +
          "&paginate=true&page=1&perPage=20" +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TravelDocResponse.serializer,
    );

    TravelDocResponse dataResult = data.onSuccess as TravelDocResponse;

    return dataResult;
  }

  Future<TravelDocDetailResponse> patchUpdateTravelDoc(
      String id, UpdateTravelDocRequest updateTravelDocRequest) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data =
        await patchdataAPIHeadersBodyWithFileDio(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.travelDocUrl + "/$id",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      bodyObject: updateTravelDocRequest.toMap(),
      serializer: TravelDocDetailResponse.serializer,
    );

    TravelDocDetailResponse dataResult =
        data.onSuccess as TravelDocDetailResponse;

    return dataResult;
  }

  Future<TravelDocDetailResponse> postSendImageTravelDoc(
      AttachmentRequest attachmentRequest) async {
    var token = await sharedPref.getTokenUser();

    // String fileName = avatar.path.split('/').last;

    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.travelDocUrl +
          "/${attachmentRequest.id}" +
          "/attachments",
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TravelDocDetailResponse.serializer,
      bodyObject: attachmentRequest.toMap(),
    );

    TravelDocDetailResponse dataResult =
        data.onSuccess as TravelDocDetailResponse;

    return dataResult;
  }

  Future<TubeResponse> getStockTubeByStatus(String status, String key) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.tubeUrl +
          "/$status?" +
          key +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TubeResponse.serializer,
    );

    TubeResponse dataResult = data.onSuccess as TubeResponse;

    return dataResult;
  }

  Future<TubeDetailResponse> getTubeDetail(String id, String key) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.tubeUrl + "/$id" + key,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TubeDetailResponse.serializer,
    );

    TubeDetailResponse dataResult = data.onSuccess as TubeDetailResponse;

    return dataResult;
  }

  Future<TubeResponse> getSearchStockTube(String value) async {
    var token = await sharedPref.getTokenUser();
    var status = await sharedPref.getStockTubeStatus();
    String resultStatus;

    if (status == 0) {
      resultStatus = "in-house";
    } else {
      resultStatus = "outside";
    }

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.tubeUrl +
          "/$resultStatus?search=$value" +
          "&paginate=true&page=1&perPage=50" +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TubeResponse.serializer,
    );

    TubeResponse dataResult = data.onSuccess as TubeResponse;

    return dataResult;
  }

  Future<TubeResponse> getLoadTube(String key) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.tubeUrl +
          "/load?" +
          key +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TubeResponse.serializer,
    );

    TubeResponse dataResult = data.onSuccess as TubeResponse;

    return dataResult;
  }

  Future<DropdownDriverResponse> getDropdownDriver() async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.travelDocUrl + "/dropdowns",
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: DropdownDriverResponse.serializer,
    );

    DropdownDriverResponse dataResult =
        data.onSuccess as DropdownDriverResponse;

    return dataResult;
  }

  Future<TubeResponse> getSearchLoadTube(String value) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.tubeUrl +
          "/load?" +
          "search=$value" +
          "&paginate=true&page=1&perPage=100" +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TubeResponse.serializer,
    );

    TubeResponse dataResult = data.onSuccess as TubeResponse;

    return dataResult;
  }

  Future<MessageResponse> postSaveDataScanTube(ScanTubeRequest request) async {
    var token = await sharedPref.getTokenUser();
    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
            baseUrl:
                ApiConstant.baseUrlDev + ApiConstant.tubeUrl + "/to-warehouse",
            headers: {
              "Accept": "application/json",
              "AUTHORIZATION": 'Bearer ' + token,
            },
            endPoint: "",
            nullSafety: {},
            serializer: MessageResponse.serializer,
            bodyObject: request.toMap());

    MessageResponse dataResult = data.onSuccess as MessageResponse;

    return dataResult;
  }

  Future<MessageResponse> postSaveDataScanTubeOut(
      ScanTubeRequest request) async {
    var token = await sharedPref.getTokenUser();
    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
            baseUrl:
                ApiConstant.baseUrlDev + ApiConstant.tubeUrl + "/to-refill",
            headers: {
              "Accept": "application/json",
              "AUTHORIZATION": 'Bearer ' + token,
            },
            endPoint: "",
            nullSafety: {},
            serializer: MessageResponse.serializer,
            bodyObject: request.toMap());

    MessageResponse dataResult = data.onSuccess as MessageResponse;

    return dataResult;
  }

  Future<DropdownTubeResponse> getDropdownTube() async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.tubeUrl + "/dropdowns",
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: DropdownTubeResponse.serializer,
    );

    DropdownTubeResponse dataResult = data.onSuccess as DropdownTubeResponse;

    return dataResult;
  }

  Future<TubeDetailResponse> putUpdateStockTube(
      UpdateTubeRequest request) async {
    var token = await sharedPref.getTokenUser();
    Tupple<HandleFailure, ResponseObject> data = await putdataAPIHeadersBody(
        baseUrl:
            ApiConstant.baseUrlDev + ApiConstant.tubeUrl + "/${request.tubeId}",
        headers: {
          "Accept": "application/json",
          "AUTHORIZATION": 'Bearer ' + token,
          "Content-Type": "application/json",
        },
        endPoint: "",
        nullSafety: {},
        serializer: TubeDetailResponse.serializer,
        bodyObject: request.toMap());

    TubeDetailResponse dataResult = data.onSuccess as TubeDetailResponse;

    return dataResult;
  }

  Future<MessageResponse> postSaveDataScanTubeFillingStaf(
      ScanTubeRequest request) async {
    var token = await sharedPref.getTokenUser();
    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
            baseUrl: ApiConstant.baseUrlDev + ApiConstant.tubeUrl + "/refilled",
            headers: {
              "Accept": "application/json",
              "AUTHORIZATION": 'Bearer ' + token,
            },
            endPoint: "",
            nullSafety: {},
            serializer: MessageResponse.serializer,
            bodyObject: request.toMap());

    MessageResponse dataResult = data.onSuccess as MessageResponse;

    return dataResult;
  }

  Future<MessageResponse> postSaveDataScanTakingDriverStaf(
      ScanTubeRequest request) async {
    var token = await sharedPref.getTokenUser();
    Tupple<HandleFailure, ResponseObject> data =
        await postdataAPIHeadersBodyWithFileDio(
            baseUrl: ApiConstant.baseUrlDev + ApiConstant.tubeUrl + "/returned",
            headers: {
              "Accept": "application/json",
              "AUTHORIZATION": 'Bearer ' + token,
            },
            endPoint: "",
            nullSafety: {},
            serializer: MessageResponse.serializer,
            bodyObject: request.toMap());

    MessageResponse dataResult = data.onSuccess as MessageResponse;

    return dataResult;
  }

  Future<TubeResponse> getLoadTubeDriver(String key) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.tubeUrl +
          "/load?" +
          key +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TubeResponse.serializer,
    );

    TubeResponse dataResult = data.onSuccess as TubeResponse;

    return dataResult;
  }

  Future<TubeResponse> getSearchLoadTubeDriver(String value) async {
    var token = await sharedPref.getTokenUser();
    var status = await sharedPref.getLoadTubeDriverStatus();
    String resultStatus;

    if (status == 0) {
      resultStatus = "Terisi";
    } else {
      resultStatus = "Kosong";
    }

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.tubeUrl +
          "/load?" +
          "search=$value" +
          "&paginate=true&page=1&perPage=20" +
          '&filters={"status": ["$resultStatus"]}' +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TubeResponse.serializer,
    );

    TubeResponse dataResult = data.onSuccess as TubeResponse;

    return dataResult;
  }

  Future<TubeResponse> getStockTubeFillingStaf(String key) async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev +
          ApiConstant.tubeUrl +
          "/refill-stock?" +
          key +
          StringConst.sortOrderByKey,
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: TubeResponse.serializer,
    );

    TubeResponse dataResult = data.onSuccess as TubeResponse;

    return dataResult;
  }

  Future<FiltersTubeResponse> getFiltersTube() async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + ApiConstant.tubeUrl + "/filters",
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: FiltersTubeResponse.serializer,
    );

    FiltersTubeResponse dataResult = data.onSuccess as FiltersTubeResponse;

    return dataResult;
  }

  Future<NotificationResponse> getNotification() async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeadersString(
      baseUrl: ApiConstant.baseUrlDev + "notifications",
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: "",
      serializer: NotificationResponse.serializer,
    );

    NotificationResponse dataResult = data.onSuccess as NotificationResponse;

    return dataResult;
  }

  Future<NotifSummaryResponse> getNotificationSummary() async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await getdataAPIHeaders(
      baseUrl: ApiConstant.baseUrlDev + "notifications/summary",
      headers: {
        "Accept": "application/json",
        "AUTHORIZATION": 'Bearer ' + token,
      },
      endPoint: "",
      nullSafety: {},
      serializer: NotifSummaryResponse.serializer,
    );

    NotifSummaryResponse dataResult = data.onSuccess as NotifSummaryResponse;

    return dataResult;
  }

  Future<MessageResponse> postReadAllNotif() async {
    var token = await sharedPref.getTokenUser();

    Tupple<HandleFailure, ResponseObject> data = await postdataAPIHeadersBody(
        baseUrl: ApiConstant.baseUrlDev + "notifications/read-all",
        headers: {
          "Accept": "application/json",
          "AUTHORIZATION": 'Bearer ' + token,
        },
        endPoint: "",
        nullSafety: {},
        serializer: MessageResponse.serializer,
        bodyObject: {});

    MessageResponse dataResult = data.onSuccess as MessageResponse;

    return dataResult;
  }
}
