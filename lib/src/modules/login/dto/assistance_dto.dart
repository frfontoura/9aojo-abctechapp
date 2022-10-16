// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AssistanceDTO {
  final String assistanceCode;
  final String name;
  final String description;

  AssistanceDTO({
    required this.assistanceCode,
    required this.name,
    required this.description,
  });

  AssistanceDTO copyWith({
    String? assistanceCode,
    String? name,
    String? description,
  }) {
    return AssistanceDTO(
      assistanceCode: assistanceCode ?? this.assistanceCode,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'assistanceCode': assistanceCode,
      'name': name,
      'description': description,
    };
  }

  factory AssistanceDTO.fromMap(Map<String, dynamic> map) {
    return AssistanceDTO(
      assistanceCode: map['assistanceCode'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssistanceDTO.fromJson(String source) => AssistanceDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AssistanceDTO(assistanceCode: $assistanceCode, name: $name, description: $description)';

  @override
  bool operator ==(covariant AssistanceDTO other) {
    if (identical(this, other)) return true;

    return other.assistanceCode == assistanceCode && other.name == name && other.description == description;
  }

  @override
  int get hashCode => assistanceCode.hashCode ^ name.hashCode ^ description.hashCode;
}
