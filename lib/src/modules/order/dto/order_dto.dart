// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:abctechapp/src/modules/order/dto/order_location_dto.dart';
import 'package:flutter/foundation.dart';

class OrderDTO {
  final String? orderCode;
  final List<String> assistsCodes;
  final OrderLocationDTO startOrderLocation;
  final OrderLocationDTO? finishOrderLocation;

  OrderDTO({
    this.orderCode,
    required this.assistsCodes,
    required this.startOrderLocation,
    this.finishOrderLocation,
  });

  OrderDTO copyWith({
    String? orderCode,
    List<String>? assistsCodes,
    OrderLocationDTO? startOrderLocation,
    OrderLocationDTO? finishOrderLocation,
  }) {
    return OrderDTO(
      orderCode: orderCode ?? this.orderCode,
      assistsCodes: assistsCodes ?? this.assistsCodes,
      startOrderLocation: startOrderLocation ?? this.startOrderLocation,
      finishOrderLocation: finishOrderLocation ?? this.finishOrderLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderCode': orderCode,
      'assistsCodes': assistsCodes,
      'startOrderLocation': startOrderLocation.toMap(),
      'finishOrderLocation': finishOrderLocation?.toMap(),
    };
  }

  factory OrderDTO.fromMap(Map<String, dynamic> map) {
    return OrderDTO(
      orderCode: map['orderCode'] as String,
      assistsCodes: List<String>.from((map['assistsCodes'] as List<dynamic>)),
      startOrderLocation: OrderLocationDTO.fromMap(map['startOrderLocation'] as Map<String, dynamic>),
      finishOrderLocation:
          map['finishOrderLocation'] != null ? OrderLocationDTO.fromMap(map['finishOrderLocation'] as Map<String, dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDTO.fromJson(String source) => OrderDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderDTO(orderCode: $orderCode, assistsCodes: $assistsCodes, startOrderLocation: $startOrderLocation, finishOrderLocation: $finishOrderLocation)';
  }

  @override
  bool operator ==(covariant OrderDTO other) {
    if (identical(this, other)) return true;

    return other.orderCode == orderCode &&
        listEquals(other.assistsCodes, assistsCodes) &&
        other.startOrderLocation == startOrderLocation &&
        other.finishOrderLocation == finishOrderLocation;
  }

  @override
  int get hashCode {
    return orderCode.hashCode ^ assistsCodes.hashCode ^ startOrderLocation.hashCode ^ finishOrderLocation.hashCode;
  }
}
