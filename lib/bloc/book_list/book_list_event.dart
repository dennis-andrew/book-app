abstract class BookListEvent {}

class LoadMoreBooksEvent extends BookListEvent {}

class SearchBooksEvent extends BookListEvent {
  final String query;

  SearchBooksEvent(this.query);
}

class FilterBooksByPriceEvent extends BookListEvent {
  final String filter;

  FilterBooksByPriceEvent(this.filter);
}

class SortBooksEvent extends BookListEvent {
  final String sortOption;

  SortBooksEvent(this.sortOption);
}
