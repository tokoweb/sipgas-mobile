import 'package:shared_preferences/shared_preferences.dart';

abstract class StringSharedPreferences {
  static const onBoarding = "onboardingCache";
  static const tokenUser = "tokenUser";
  static const loginUser = "loginUsers";
  static const userData = "userData";
  static const languageData = "languageData";
  static const roleUser = "roleUser";
  static const travelDocStatus = "travelDocStatus";
  static const stockTubeStatus = "stockTubeStatus";
  static const loadTubeDriverStatus = "loadTubeDriverStatus";
  static const userId = "userId";
  static const tubeScanTravel = "tubeScanTravel";
  static const stockTubeFillingStatus = "stockTubeFillingStatus";
}

class SharedPref {
  final SharedPreferences preferences;

  SharedPref({required this.preferences});

  // void setPrefOnBoarding(bool val) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool(StringSharedPreferences.onBoarding, val);
  // }

  // Future<bool> getPrefOnBoarding() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool value = prefs.getBool(StringSharedPreferences.onBoarding) ?? false;
  //   return value;
  // }

  // void setPrefLanguage(String language) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(StringSharedPreferences.languageData, language);
  // }

  // Future<String> getPrefLanguage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String value = prefs.getString(StringSharedPreferences.languageData) ?? "";
  //   return value;
  // }

  void setPrefLogin(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(StringSharedPreferences.loginUser, val);
  }

  Future<int> getPrefLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(StringSharedPreferences.loginUser) ?? 0;
    return value;
  }

  void setUserData(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StringSharedPreferences.userData, val);
  }

  Future<String> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(StringSharedPreferences.userData) ?? "";
    return value;
  }

  void setTokenUser(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StringSharedPreferences.tokenUser, val);
  }

  Future<String> getTokenUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(StringSharedPreferences.tokenUser) ?? "";
    return value;
  }

  Future<bool> deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(StringSharedPreferences.loginUser);
    return true;
  }

  void setRoleUser(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StringSharedPreferences.roleUser, val);
  }

  Future<String> getRoleUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(StringSharedPreferences.roleUser) ?? "";
    return value;
  }

  void setTravelDocStatus(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(StringSharedPreferences.travelDocStatus, val);
  }

  Future<int> getTravelDocStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(StringSharedPreferences.travelDocStatus) ?? 0;
    return value;
  }

  void setStockTubeStatus(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(StringSharedPreferences.stockTubeStatus, val);
  }

  Future<int> getStockTubeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(StringSharedPreferences.stockTubeStatus) ?? 0;
    return value;
  }

  void setUserId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StringSharedPreferences.userId, id);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(StringSharedPreferences.userId) ?? "";
    return value;
  }

  void setLoadTubeDriverStatus(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(StringSharedPreferences.loadTubeDriverStatus, val);
  }

  Future<int> getLoadTubeDriverStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(StringSharedPreferences.loadTubeDriverStatus) ?? 0;
    return value;
  }

  void setTubeScanTravel(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(StringSharedPreferences.tubeScanTravel, val);
  }

  Future<int> getTubeScanTravel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value = prefs.getInt(StringSharedPreferences.tubeScanTravel) ?? 0;
    return value;
  }

  void setStockTubeFillingStafStatus(int val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(StringSharedPreferences.stockTubeFillingStatus, val);
  }

  Future<int> getStockTubeFillingStafStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int value =
        prefs.getInt(StringSharedPreferences.stockTubeFillingStatus) ?? 0;
    return value;
  }
}
