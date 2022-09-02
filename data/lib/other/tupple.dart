import 'package:data/other/response_object.dart';

class Tupple<HandleFailure, ResponseObject> {
  HandleFailure? handleFailure;
  ResponseObject? onSuccess;

  Tupple({this.handleFailure, this.onSuccess});
}
