// import 'package:book_app/author.dart';
//
// class Book {
//   final String title;
//   final Author author;
//   final double price;
//
//   Book({required this.title, required this.author, required this.price});
//
//   Book.fromJson(Map<String, dynamic> json)
//       : title = json['title'] as String,
//         author = Author.fromJson(json['author']),
//         price = json['price'] as double;
//
//
//   Map<String, dynamic> toJson() => {
//     'title': title,
//     'author': author,
//     'price':price
//   };
// }


import 'package:json_annotation/json_annotation.dart';
import 'package:book_app/author.dart';

part 'book.g.dart';

@JsonSerializable(explicitToJson: true)
class Book {
  final String title;
  final Author author;
  final double price;

  Book({required this.title, required this.author, required this.price});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

