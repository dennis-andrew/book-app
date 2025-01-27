import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/book.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<AddToCartEvent>((event, emit) {
      final updatedCart = List<Book>.from(state.cartItems)..add(event.book);
      emit(CartState(updatedCart));
    });

    on<RemoveFromCartEvent>((event, emit) {
      final updatedCart = List<Book>.from(state.cartItems)..remove(event.book);
      emit(CartState(updatedCart));
    });
  }
}
