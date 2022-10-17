// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:abctechapp/src/modules/order/dto/order_location_dto.dart';
import 'package:flutter/foundation.dart';

import 'package:abctechapp/src/modules/assists/dto/assistance_dto.dart';

class OrderDetailDTO {
  final String orderCode;
  final List<AssistanceDTO> assists;
  final OrderLocationDTO startOrderLocation;
  final OrderLocationDTO? finishOrderLocation;

  OrderDetailDTO({
    required this.orderCode,
    required this.assists,
    required this.startOrderLocation,
    this.finishOrderLocation,
  });

  OrderDetailDTO copyWith({
    String? orderCode,
    List<AssistanceDTO>? assists,
    OrderLocationDTO? startOrderLocation,
    OrderLocationDTO? finishOrderLocation,
  }) {
    return OrderDetailDTO(
      orderCode: orderCode ?? this.orderCode,
      assists: assists ?? this.assists,
      startOrderLocation: startOrderLocation ?? this.startOrderLocation,
      finishOrderLocation: finishOrderLocation ?? this.finishOrderLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderCode': orderCode,
      'assists': assists.map((x) => x.toMap()).toList(),
      'startOrderLocation': startOrderLocation.toMap(),
      'finishOrderLocation': finishOrderLocation?.toMap(),
    };
  }

  factory OrderDetailDTO.fromMap(Map<String, dynamic> map) {
    return OrderDetailDTO(
      orderCode: map['orderCode'] as String,
      assists: List<AssistanceDTO>.from(
        (map['assists'] as List<int>).map<AssistanceDTO>(
          (x) => AssistanceDTO.fromMap(x as Map<String, dynamic>),
        ),
      ),
      startOrderLocation: OrderLocationDTO.fromMap(map['startOrderLocation'] as Map<String, dynamic>),
      finishOrderLocation:
          map['finishOrderLocation'] != null ? OrderLocationDTO.fromMap(map['finishOrderLocation'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetailDTO.fromJson(String source) => OrderDetailDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderDetailDTO(orderCode: $orderCode, assists: $assists, startOrderLocation: $startOrderLocation, finishOrderLocation: $finishOrderLocation)';
  }

  @override
  bool operator ==(covariant OrderDetailDTO other) {
    if (identical(this, other)) return true;

    return other.orderCode == orderCode &&
        listEquals(other.assists, assists) &&
        other.startOrderLocation == startOrderLocation &&
        other.finishOrderLocation == finishOrderLocation;
  }

  @override
  int get hashCode {
    return orderCode.hashCode ^ assists.hashCode ^ startOrderLocation.hashCode ^ finishOrderLocation.hashCode;
  }
}
