import 'dart:convert';

import 'package:book_app/book.dart';

String booksJson = '''
  [
  {"title": "The Great Gatsby", "author": {"name": "F. Scott Fitzgerald", "email": "fscott@gmail.com"}, "price": 10.99},
  {"title": "To Kill a Mockingbird", "author": {"name": "Harper Lee", "email": "harper.lee@gmail.com"}, "price": 7.99},
  {"title": "1984", "author": {"name": "George Orwell", "email": "orwell.george@gmail.com"}, "price": 8.99},
  {"title": "Pride and Prejudice", "author": {"name": "Jane Austen", "email": "jane.austen@gmail.com"}, "price": 6.99},
  {"title": "The Catcher in the Rye", "author": {"name": "J.D. Salinger", "email": "salinger.jd@gmail.com"}, "price": 9.99},
  {"title": "Moby-Dick", "author": {"name": "Herman Melville", "email": "herman.melville@gmail.com"}, "price": 11.99},
  {"title": "The Hobbit", "author": {"name": "J.R.R. Tolkien", "email": "tolkien.jrr@gmail.com"}, "price": 10.49},
  {"title": "The Alchemist", "author": {"name": "Paulo Coelho", "email": "paulo.coelho@gmail.com"}, "price": 9.99},
  {"title": "Crime and Punishment", "author": {"name": "Fyodor Dostoevsky", "email": "fyodor.dostoevsky@gmail.com"}, "price": 14.99},
  {"title": "War and Peace", "author": {"name": "Leo Tolstoy", "email": "leo.tolstoy@gmail.com"}, "price": 19.99},
  {"title": "The Lord of the Rings", "author": {"name": "J.R.R. Tolkien", "email": "tolkien.jrr@gmail.com"}, "price": 22.99},
  {"title": "Brave New World", "author": {"name": "Aldous Huxley", "email": "aldous.huxley@gmail.com"}, "price": 9.49}
]
  ''';

List<dynamic> jsonList = json.decode(booksJson);
List<Book> books = jsonList.map((json) => Book.fromJson(json)).toList();