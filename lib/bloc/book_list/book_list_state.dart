import 'package:book_app/models/book.dart';

abstract class BookListState {}

class BookListLoadingState extends BookListState {}

class BookListLoadedState extends BookListState {
  final List<Book> filteredBooks;
  final bool hasMore;

  BookListLoadedState({
    required this.filteredBooks,
    required this.hasMore,
  });
}
