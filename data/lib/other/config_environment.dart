import 'dart:io';
import 'package:core/network/api_constant.dart';

class ConfigEnvironment {
  final String baseUrl = ApiConstant.baseUrlDev;
  final headers = {
    HttpHeaders.contentTypeHeader: "application/json",
  };
}
