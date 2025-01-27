import '../../models/book.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final Book book;

  AddToCartEvent(this.book);
}

class RemoveFromCartEvent extends CartEvent {
  final Book book;

  RemoveFromCartEvent(this.book);
}