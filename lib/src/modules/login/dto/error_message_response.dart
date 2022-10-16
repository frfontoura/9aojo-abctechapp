// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ErrorMessageResponse {
  final int statusCode;
  final String message;
  final String? description;
  final DateTime time;

  ErrorMessageResponse({
    required this.statusCode,
    required this.message,
    this.description,
    required this.time,
  });

  ErrorMessageResponse copyWith({
    int? statusCode,
    String? message,
    String? description,
    DateTime? time,
  }) {
    return ErrorMessageResponse(
      statusCode: statusCode ?? this.statusCode,
      message: message ?? this.message,
      description: description ?? this.description,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'message': message,
      'description': description,
      'time': time,
    };
  }

  factory ErrorMessageResponse.fromMap(Map<String, dynamic> map) {
    return ErrorMessageResponse(
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      time: DateTime.parse(map['time'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorMessageResponse.fromJson(String source) => ErrorMessageResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ErrorMessageResponse(statusCode: $statusCode, message: $message, description: $description, time: $time)';
  }

  @override
  bool operator ==(covariant ErrorMessageResponse other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode && other.message == message && other.description == description && other.time == time;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^ message.hashCode ^ description.hashCode ^ time.hashCode;
  }
}
