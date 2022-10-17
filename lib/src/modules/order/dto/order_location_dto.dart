// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderLocationDTO {
  final String orderLocationCode;
  final double latitude;
  final double longitude;
  final DateTime dateTime;

  OrderLocationDTO({
    required this.orderLocationCode,
    required this.latitude,
    required this.longitude,
    required this.dateTime,
  });

  OrderLocationDTO copyWith({
    String? orderLocationCode,
    double? latitude,
    double? longitude,
    DateTime? dateTime,
  }) {
    return OrderLocationDTO(
      orderLocationCode: orderLocationCode ?? this.orderLocationCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderLocationCode': orderLocationCode,
      'latitude': latitude,
      'longitude': longitude,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory OrderLocationDTO.fromMap(Map<String, dynamic> map) {
    return OrderLocationDTO(
      orderLocationCode: map['orderLocationCode'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      dateTime: DateTime.parse(map['dateTime'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderLocationDTO.fromJson(String source) => OrderLocationDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderLocationDTO(orderLocationCode: $orderLocationCode, latitude: $latitude, longitude: $longitude, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant OrderLocationDTO other) {
    if (identical(this, other)) return true;

    return other.orderLocationCode == orderLocationCode &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return orderLocationCode.hashCode ^ latitude.hashCode ^ longitude.hashCode ^ dateTime.hashCode;
  }
}
