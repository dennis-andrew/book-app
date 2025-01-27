import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_app/data/books.dart';
import 'package:book_app/models/book.dart';
import 'book_list_event.dart';
import 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  static const int pageSize = 10;
  int currentPage = 0;

  BookListBloc() : super(BookListLoadedState(filteredBooks: (books), hasMore: true)) {
    on<LoadMoreBooksEvent>(_onLoadMoreBooks);
    on<SearchBooksEvent>(_onSearchBooks);
    on<FilterBooksByPriceEvent>(_onFilterBooksByPrice);
    on<SortBooksEvent>(_onSortBooks);
  }

  void _onLoadMoreBooks(LoadMoreBooksEvent event, Emitter<BookListState> emit) async {
    if (state is BookListLoadingState) return;

    emit(BookListLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    int nextPage = currentPage + 1;
    if (nextPage * pageSize < books.length) {
      List<Book> newBooks = books.skip(nextPage * pageSize).take(pageSize).toList();

      currentPage = nextPage;
      emit(BookListLoadedState(filteredBooks: newBooks, hasMore: true));
    } else {
      emit(BookListLoadedState(filteredBooks: books, hasMore: false));
    }
  }

  void _onSearchBooks(SearchBooksEvent event, Emitter<BookListState> emit) {
    List<Book> filteredBooks = books
        .where((book) =>
    book.title.toLowerCase().contains(event.query.toLowerCase()) ||
        book.author.name.toLowerCase().contains(event.query.toLowerCase()))
        .toList();

    emit(BookListLoadedState(filteredBooks: filteredBooks, hasMore: true));
  }

  void _onFilterBooksByPrice(FilterBooksByPriceEvent event, Emitter<BookListState> emit) {
    List<Book> filteredBooks;

    switch (event.filter) {
      case "< \$10":
        filteredBooks = books.where((book) => book.price < 10).toList();
        break;
      case "\$10 - \$15":
        filteredBooks = books
            .where((book) => book.price >= 10 && book.price <= 15)
            .toList();
        break;
      case "> \$15":
        filteredBooks = books.where((book) => book.price > 15).toList();
        break;
      default:
        filteredBooks = books;
    }

    emit(BookListLoadedState(filteredBooks: filteredBooks, hasMore: true));
  }

  void _onSortBooks(SortBooksEvent event, Emitter<BookListState> emit) {
    List<Book> sortedBooks;

    switch (event.sortOption) {
      case "Title (Ascending)":
        sortedBooks = List.from(books)
          ..sort((a, b) => a.title.compareTo(b.title));
        break;
      case "Title (Descending)":
        sortedBooks = List.from(books)
          ..sort((a, b) => b.title.compareTo(a.title));
        break;
      case "Price (Ascending)":
        sortedBooks = List.from(books)
          ..sort((a, b) => a.price.compareTo(b.price));
        break;
      case "Price (Descending)":
        sortedBooks = List.from(books)
          ..sort((a, b) => b.price.compareTo(a.price));
        break;
      default:
        sortedBooks = books;
    }

    emit(BookListLoadedState(filteredBooks: sortedBooks, hasMore: true));
  }
}
