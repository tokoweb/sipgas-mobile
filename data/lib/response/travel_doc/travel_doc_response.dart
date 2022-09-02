import 'dart:convert';
import 'package:data/other/response_object.dart';
import 'package:data/request/request.dart';
import 'package:data/response/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'travel_doc_response.g.dart';

class TravelDocResponse extends ResponseObject {
  @JsonKey(name: 'results')
  List<SubTravelDocResponse>? listTravelDoc;

  @JsonKey(name: 'pagination')
  PaginationData? pagination;

  TravelDocResponse({
    this.listTravelDoc,
    this.pagination,
  });

  factory TravelDocResponse.fromJson(Map<String, dynamic> json) =>
      _$TravelDocResponseFromJson(json);

  static get serializer => _$TravelDocResponseFromJson;
}

class SubTravelDocResponse {
  int? id;
  String? code;
  String? date;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? tanksCount;
  CustomerData? customerData;
  List<TankCategoriesData>? tankCategoriesData;

  SubTravelDocResponse({
    required this.id,
    required this.code,
    required this.date,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.tanksCount,
    required this.customerData,
    required this.tankCategoriesData,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'date': date,
      'type': type,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'tanks_count': tanksCount,
      'customer': customerData,
      'tank_categories': tankCategoriesData,
    };
  }

  factory SubTravelDocResponse.fromMap(Map<String, dynamic> map) {
    return SubTravelDocResponse(
      id: map['id'],
      code: map['code'],
      date: map['date'],
      type: map['type'],
      status: map['status'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
      tanksCount: map['tanks_count'],
      customerData: map['customer'] == null
          ? null
          : CustomerData.fromMap(map['customer'] as Map<String, dynamic>),
      tankCategoriesData: map['tank_categories'] != null
          ? (map['tank_categories'] as List<dynamic>)
              .map((e) => TankCategoriesData.fromMap(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTravelDocResponse.fromJson(String source) =>
      SubTravelDocResponse.fromMap(json.decode(source));
}

class CustomerData {
  int? id;
  int? deliveryId;
  int? customerId;
  String? type;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? picName;
  String? picPhone;
  String? createdAt;
  String? updatedAt;

  CustomerData({
    this.id,
    this.deliveryId,
    this.customerId,
    this.type,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.picName,
    this.picPhone,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'delivery_id': deliveryId,
      'customer_id': customerId,
      'type': type,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'pic_name': picName,
      'pic_phone': picPhone,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory CustomerData.fromMap(Map<String, dynamic> map) {
    return CustomerData(
      id: map['id'],
      deliveryId: map['delivery_id'],
      customerId: map['customer_id'],
      type: map['type'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      address: map['address'],
      picName: map['pic_name'] ?? '',
      picPhone: map['pic_phone'] ?? '',
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory CustomerData.fromJson(String source) =>
      CustomerData.fromMap(json.decode(source));
}

class TankCategoriesData {
  int? id;
  int? deliveryId;
  int? tankCategoryId;
  String? name;
  String? size;
  String? note;
  int? qty;
  String? createdAt;
  String? updatedAt;
  List<TubesData>? tanks;

  TankCategoriesData({
    this.id,
    this.deliveryId,
    this.tankCategoryId,
    this.name,
    this.size,
    this.note,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.tanks,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'delivery_id': deliveryId,
      'tank_category_id': tankCategoryId,
      'name': name,
      'size': size,
      'note': note,
      'qty': qty,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'tanks': tanks,
    };
  }

  factory TankCategoriesData.fromMap(Map<String, dynamic> map) {
    return TankCategoriesData(
        id: map['id'],
        deliveryId: map['delivery_id'],
        tankCategoryId: map['tank_category_id'],
        name: map['name'],
        size: map['size'],
        note: map['note'],
        qty: map['qty'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        tanks: map['tanks'] != null
            ? (map['tanks'] as List<dynamic>)
                .map((e) => TubesData.fromMap(e as Map<String, dynamic>))
                .toList()
            : null);
  }

  String toJson() => jsonEncode(toMap());

  factory TankCategoriesData.fromJson(String source) =>
      TankCategoriesData.fromMap(json.decode(source));
}

class PaginationData {
  int? page;
  int? perPage;
  int? lastPage;
  int? start;
  int? end;
  int? total;

  PaginationData({
    this.page,
    this.perPage,
    this.lastPage,
    this.start,
    this.end,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'perPage': perPage,
      'lastPage': lastPage,
      'start': start,
      'end': end,
      'total': total,
    };
  }

  factory PaginationData.fromMap(Map<String, dynamic> map) {
    return PaginationData(
      page: map['page'],
      perPage: map['perPage'],
      lastPage: map['lastPage'],
      start: map['start'],
      end: map['end'],
      total: map['total'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory PaginationData.fromJson(String source) =>
      PaginationData.fromMap(json.decode(source));
}
