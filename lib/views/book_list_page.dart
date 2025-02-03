import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_app/views/book_details_page.dart';
import 'package:book_app/views/cart_page.dart';
import 'package:book_app/bloc/book_list/book_list_bloc.dart';
import 'package:book_app/bloc/book_list/book_list_event.dart';
import 'package:book_app/bloc/book_list/book_list_state.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../bloc/theme/theme_bloc.dart';
import '../bloc/theme/theme_event.dart';

class BookListPage extends StatelessWidget {
  const BookListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: context.watch<ThemeBloc>().state.themeMode == ThemeMode.light ? const Icon(Icons.dark_mode) : const Icon(Icons.light_mode),
          onPressed:  (){
            context.read<ThemeBloc>().add(ToggleTheme());
          }
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (query) {
                      context.read<BookListBloc>().add(SearchBooksEvent(query));
                    },
                    decoration: const InputDecoration(
                      labelText: 'Search Books',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton(
                  value: 'All',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      context.read<BookListBloc>().add(FilterBooksByPriceEvent(newValue));
                    }
                  },
                  items: ['All', '< \$10', '\$10 - \$15', '> \$15']
                      .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                      .toList(),
                ),
                const SizedBox(width: 8),
                DropdownButton(
                  value: 'Title (Ascending)',
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      context.read<BookListBloc>().add(SortBooksEvent(newValue));
                    }
                  },
                  items: [
                    'Title (Ascending)',
                    'Title (Descending)',
                    'Price (Ascending)',
                    'Price (Descending)'
                  ].map((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<BookListBloc, BookListState>(
              builder: (context, state) {
                if (state is BookListLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is BookListLoadedState) {
                  return LazyLoadScrollView(
                    onEndOfPage: () {
                      context.read<BookListBloc>().add(LoadMoreBooksEvent());
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: state.filteredBooks.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.filteredBooks.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final book = state.filteredBooks[index];
                        return Card(
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.grey[200],
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://images.pexels.com/photos/159711/books-bookstore-book-reading-159711.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'by ${book.author.name}',
                                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '\$${book.price}',
                                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookDetailsPage(book: book),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Details',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
