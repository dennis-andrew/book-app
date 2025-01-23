import 'package:flutter/material.dart';
import 'package:book_app/book_details_page.dart';
import 'package:book_app/book.dart';
import 'package:book_app/cart_page.dart';
import 'package:book_app/books.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> filteredBooks = [];
  TextEditingController searchController = TextEditingController();
  String selectedPriceFilter = "All";
  String selectedSortOption = "Title (Ascending)";
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 0;
  final int pageSize = 10;

  @override
  void initState() {
    super.initState();
    filteredBooks = books.take(pageSize).toList();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading && hasMore) {
      loadMoreBooks();
    }
  }

  Future<void> loadMoreBooks() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));

    int nextPage = currentPage + 1;
    if (nextPage * pageSize < books.length) {
      List<Book> newBooks = books.skip(nextPage * pageSize).take(pageSize).toList();

      setState(() {
        filteredBooks.addAll(newBooks);
        currentPage = nextPage;
        isLoading = false;
      });
    } else {
      setState(() {
        hasMore = false;
        isLoading = false;
      });
    }
  }

  void filterBooks(String query) {
    setState(() {
      filteredBooks = books
          .where((book) =>
      book.title.toLowerCase().contains(query.toLowerCase()) ||
          book.author.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      sortBooks(selectedSortOption);
    });
  }

  void filterBooksByPrice(String filter) {
    setState(() {
      selectedPriceFilter = filter;
      if (filter == "All") {
        filteredBooks = books;
      } else if (filter == "< \$10") {
        filteredBooks = books.where((book) => book.price < 10).toList();
      } else if (filter == "\$10 - \$15") {
        filteredBooks = books
            .where((book) => book.price >= 10 && book.price <= 15)
            .toList();
      } else if (filter == "> \$15") {
        filteredBooks = books.where((book) => book.price > 15).toList();
      }
      sortBooks(selectedSortOption); // Apply sorting after filtering
    });
  }

  void sortBooks(String option) {
    setState(() {
      if (option == "Title (Ascending)") {
        filteredBooks.sort((a, b) => a.title.compareTo(b.title));
      } else if (option == "Title (Descending)") {
        filteredBooks.sort((a, b) => b.title.compareTo(a.title));
      } else if (option == "Price (Ascending)") {
        filteredBooks.sort((a, b) => a.price.compareTo(b.price));
      } else if (option == "Price (Descending)") {
        filteredBooks.sort((a, b) => b.price.compareTo(a.price));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
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
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search Books',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: filterBooks,
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedPriceFilter,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      filterBooksByPrice(newValue);
                    }
                  },
                  items: <String>['All', '< \$10', '\$10 - \$15', '> \$15']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: selectedSortOption,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedSortOption = newValue;
                        sortBooks(newValue); // Apply sorting immediately
                      });
                    }
                  },
                  items: <String>[
                    'Title (Ascending)',
                    'Title (Descending)',
                    'Price (Ascending)',
                    'Price (Descending)'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: filteredBooks.length + (isLoading ? 1 : 0), // Show loading indicator if needed
              itemBuilder: (context, index) {
                if (index == filteredBooks.length) {
                  return const Center(child: CircularProgressIndicator()); // Loading indicator
                }
                final book = filteredBooks[index];
                return Card(
                  elevation: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: Image.asset("assets/images/img.png"),
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
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailsPage(book: book),
                              ),
                            );
                          },
                          child: const Text('Details'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
