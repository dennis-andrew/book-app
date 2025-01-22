class Author{
  final String name;
  final String email;

  Author({required this.name, required this.email});

  Author.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] as String;

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}

// import 'package:json_annotation/json_annotation.dart';
// part 'author.g.dart';
//
// @JsonSerializable()
// class Author {
//   final String name;
//   final String email;
//
//   Author({required this.name, required this.email});
//
//   factory Author.fromJson(Map<String, dynamic> json) =>
//       _$AuthorFromJson(json);
//   Map<String, dynamic> toJson() => _$AuthorToJson(this);
// }