// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SingupResponseDTO {
  final String username;
  final String email;

  SingupResponseDTO({
    required this.username,
    required this.email,
  });

  SingupResponseDTO copyWith({
    String? username,
    String? email,
  }) {
    return SingupResponseDTO(
      username: username ?? this.username,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
    };
  }

  factory SingupResponseDTO.fromMap(Map<String, dynamic> map) {
    return SingupResponseDTO(
      username: map['username'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingupResponseDTO.fromJson(String source) => SingupResponseDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SingupResponseDTO(username: $username, email: $email)';

  @override
  bool operator ==(covariant SingupResponseDTO other) {
    if (identical(this, other)) return true;

    return other.username == username && other.email == email;
  }

  @override
  int get hashCode => username.hashCode ^ email.hashCode;
}
