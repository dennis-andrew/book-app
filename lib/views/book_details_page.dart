import 'package:book_app/bloc/cart/cart_bloc.dart';
import 'package:book_app/bloc/cart/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:book_app/models/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsPage extends StatelessWidget {
  final Book book;

  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Author: ${book.author.name}',
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            Text('Price: \$${book.price}',
                style: const TextStyle(fontSize: 18, color: Colors.green)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(AddToCartEvent(book));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to Cart!')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
