import '../../models/book.dart';

class CartState {
  final List<Book> cartItems;

  CartState(this.cartItems);

  double getTotal() {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }
}