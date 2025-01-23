import 'package:flutter/material.dart';
import 'package:book_app/book.dart';

class Cart {
  static List<Book> cartItems = [];

  static void addToCart(Book book) {
    cartItems.add(book);
  }

  static void removeFromCart(Book book) {
    cartItems.remove(book);
  }

  static double getTotal() {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }
}

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.amber,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final item = Cart.cartItems[index];
                return Dismissible(
                  key: Key(index.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      Cart.removeFromCart(item);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Removed from Cart!')),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    child: ListTile(
                      title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('by ${item.author.name}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('\$${item.price}', style: const TextStyle(color: Colors.green)),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                Cart.removeFromCart(item);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Removed from Cart!')),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: Cart.cartItems.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text('Total: \$${Cart.getTotal()}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PaymentPage())
                      );
                    },
                    child: const Text('Proceed to Payment'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: const Center(
        child: Text(
          'Payment Successful!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    );
  }
}
