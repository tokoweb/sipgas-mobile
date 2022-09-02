import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:data/other/response_object.dart';

class AttachmentRequest extends ResponseObject {
  String? id;
  List<MultipartFile>? attachments;

  AttachmentRequest({
    this.id,
    this.attachments,
  });

  Map<String, dynamic> toMap() {
    return {
      'attachments[]': attachments!.map((e) => e).toList(),
    };
  }

  factory AttachmentRequest.fromMap(Map<String, dynamic> map) {
    return AttachmentRequest(
      attachments: map['attachments[]'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AttachmentRequest.fromJson(String source) =>
      AttachmentRequest.fromMap(json.decode(source));
}
