// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PageDTO<T> {
  final List<T> content;
  final bool last;
  final int totalPages;
  final int totalElements;
  final int numberOfElements;
  final int number;

  PageDTO({
    required this.content,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.numberOfElements,
    required this.number,
  });

  factory PageDTO.fromMap(Map<String, dynamic> map, T fromMap(dynamic)) {
    return PageDTO<T>(
      content: List<T>.from((map['content'] as List<dynamic>).map<T>((x) => fromMap(x as Map<String, dynamic>))),
      last: map['last'] as bool,
      totalPages: map['totalPages'] as int,
      totalElements: map['totalElements'] as int,
      numberOfElements: map['numberOfElements'] as int,
      number: map['number'] as int,
    );
  }

  factory PageDTO.fromJson(String source, T fromMap(dynamic)) => PageDTO.fromMap(json.decode(source) as Map<String, dynamic>, fromMap);

  @override
  String toString() {
    return 'PageDTO(content: $content, last: $last, totalPages: $totalPages, totalElements: $totalElements, numberOfElements: $numberOfElements)';
  }
}
