// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SigninRequestDTO {
  final String username;
  final String password;

  SigninRequestDTO({
    required this.username,
    required this.password,
  });

  SigninRequestDTO copyWith({
    String? username,
    String? password,
  }) {
    return SigninRequestDTO(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
    };
  }

  factory SigninRequestDTO.fromMap(Map<String, dynamic> map) {
    return SigninRequestDTO(
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SigninRequestDTO.fromJson(String source) => SigninRequestDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SigninRequestDTO(username: $username, password: $password)';

  @override
  bool operator ==(covariant SigninRequestDTO other) {
    if (identical(this, other)) return true;

    return other.username == username && other.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
