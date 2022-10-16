// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JwtResponseDTO {
  final String token;
  final String type;

  JwtResponseDTO({
    required this.token,
    required this.type,
  });

  JwtResponseDTO copyWith({
    String? token,
    String? type,
  }) {
    return JwtResponseDTO(
      token: token ?? this.token,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'type': type,
    };
  }

  factory JwtResponseDTO.fromMap(Map<String, dynamic> map) {
    return JwtResponseDTO(
      token: map['token'] as String,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JwtResponseDTO.fromJson(String source) => JwtResponseDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'JwtResponseDTO(token: $token, type: $type)';

  @override
  bool operator ==(covariant JwtResponseDTO other) {
    if (identical(this, other)) return true;

    return other.token == token && other.type == type;
  }

  @override
  int get hashCode => token.hashCode ^ type.hashCode;
}
