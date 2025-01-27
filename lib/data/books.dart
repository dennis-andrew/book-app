import 'dart:convert';

import 'package:book_app/models/book.dart';

String booksJson = '''
[
  {"title": "The Great Gatsby", "author": {"name": "F. Scott Fitzgerald", "email": "fscott@gmail.com"}, "price": 10.99},
  {"title": "To Kill a Mockingbird", "author": {"name": "Harper Lee", "email": "harper.lee@gmail.com"}, "price": 7.99},
  {"title": "1984", "author": {"name": "George Orwell", "email": "orwell.george@gmail.com"}, "price": 8.99},
  {"title": "Pride and Prejudice", "author": {"name": "Jane Austen", "email": "jane.austen@gmail.com"}, "price": 6.99},
  {"title": "The Catcher in the Rye", "author": {"name": "J.D. Salinger", "email": "salinger.jd@gmail.com"}, "price": 9.99},
  {"title": "Moby-Dick", "author": {"name": "Herman Melville", "email": "herman.melville@gmail.com"}, "price": 11.99},
  {"title": "The Hobbit", "author": {"name": "J.R.R. Tolkien", "email": "tolkien.jrr@gmail.com"}, "price": 10.49},
  {"title": "The Alchemist", "author": {"name": "Paulo Coelho", "email": "paulo.coelho@gmail.com"}, "price": 9.99},
  {"title": "Crime and Punishment", "author": {"name": "Fyodor Dostoevsky", "email": "fyodor.dostoevsky@gmail.com"}, "price": 14.99},
  {"title": "War and Peace", "author": {"name": "Leo Tolstoy", "email": "leo.tolstoy@gmail.com"}, "price": 19.99},
  {"title": "The Lord of the Rings", "author": {"name": "J.R.R. Tolkien", "email": "tolkien.jrr@gmail.com"}, "price": 22.99},
  {"title": "Brave New World", "author": {"name": "Aldous Huxley", "email": "aldous.huxley@gmail.com"}, "price": 9.49},
  {"title": "The Picture of Dorian Gray", "author": {"name": "Oscar Wilde", "email": "oscar.wilde@gmail.com"}, "price": 8.49},
  {"title": "Jane Eyre", "author": {"name": "Charlotte Brontë", "email": "charlotte.bronte@gmail.com"}, "price": 7.49},
  {"title": "The Brothers Karamazov", "author": {"name": "Fyodor Dostoevsky", "email": "fyodor.dostoevsky@gmail.com"}, "price": 13.99},
  {"title": "The Odyssey", "author": {"name": "Homer", "email": "homer.classic@gmail.com"}, "price": 12.49},
  {"title": "Wuthering Heights", "author": {"name": "Emily Brontë", "email": "emily.bronte@gmail.com"}, "price": 10.49},
  {"title": "Catch-22", "author": {"name": "Joseph Heller", "email": "joseph.heller@gmail.com"}, "price": 14.49},
  {"title": "The Sun Also Rises", "author": {"name": "Ernest Hemingway", "email": "ernest.hemingway@gmail.com"}, "price": 11.29},
  {"title": "Frankenstein", "author": {"name": "Mary Shelley", "email": "mary.shelley@gmail.com"}, "price": 8.79},
  {"title": "Fahrenheit 451", "author": {"name": "Ray Bradbury", "email": "ray.bradbury@gmail.com"}, "price": 10.29},
  {"title": "Animal Farm", "author": {"name": "George Orwell", "email": "orwell.george@gmail.com"}, "price": 6.99},
  {"title": "Brave New World", "author": {"name": "Aldous Huxley", "email": "aldous.huxley@gmail.com"}, "price": 9.49},
  {"title": "The Road", "author": {"name": "Cormac McCarthy", "email": "cormac.mccarthy@gmail.com"}, "price": 12.99},
  {"title": "The Shining", "author": {"name": "Stephen King", "email": "stephen.king@gmail.com"}, "price": 14.99},
  {"title": "The Great Expectations", "author": {"name": "Charles Dickens", "email": "charles.dickens@gmail.com"}, "price": 13.49},
  {"title": "One Hundred Years of Solitude", "author": {"name": "Gabriel García Márquez", "email": "gabriel.garcia.m@gmail.com"}, "price": 16.99},
  {"title": "The Scarlet Letter", "author": {"name": "Nathaniel Hawthorne", "email": "nathaniel.hawthorne@gmail.com"}, "price": 8.79},
  {"title": "The Kite Runner", "author": {"name": "Khaled Hosseini", "email": "khaled.hosseini@gmail.com"}, "price": 13.49},
  {"title": "The Outsiders", "author": {"name": "S.E. Hinton", "email": "se.hinton@gmail.com"}, "price": 9.49},
  {"title": "The Handmaid's Tale", "author": {"name": "Margaret Atwood", "email": "margaret.atwood@gmail.com"}, "price": 12.99},
  {"title": "The Chronicles of Narnia", "author": {"name": "C.S. Lewis", "email": "cs.lewis@gmail.com"}, "price": 11.79},
  {"title": "Slaughterhouse-Five", "author": {"name": "Kurt Vonnegut", "email": "kurt.vonnegut@gmail.com"}, "price": 9.29},
  {"title": "The Hunger Games", "author": {"name": "Suzanne Collins", "email": "suzanne.collins@gmail.com"}, "price": 10.99},
  {"title": "The Catcher in the Rye", "author": {"name": "J.D. Salinger", "email": "salinger.jd@gmail.com"}, "price": 9.99},
  {"title": "The Bell Jar", "author": {"name": "Sylvia Plath", "email": "sylvia.plath@gmail.com"}, "price": 8.99},
  {"title": "The Secret Garden", "author": {"name": "Frances Hodgson Burnett", "email": "frances.burnett@gmail.com"}, "price": 7.99},
  {"title": "The Call of the Wild", "author": {"name": "Jack London", "email": "jack.london@gmail.com"}, "price": 8.49},
  {"title": "Lord of the Flies", "author": {"name": "William Golding", "email": "william.golding@gmail.com"}, "price": 9.79},
  {"title": "The Hobbit", "author": {"name": "J.R.R. Tolkien", "email": "tolkien.jrr@gmail.com"}, "price": 10.49},
  {"title": "Dracula", "author": {"name": "Bram Stoker", "email": "bram.stoker@gmail.com"}, "price": 8.99},
  {"title": "The Fault in Our Stars", "author": {"name": "John Green", "email": "john.green@gmail.com"}, "price": 9.49}
]
''';

List<dynamic> jsonList = json.decode(booksJson);
List<Book> books = jsonList.map((json) => Book.fromJson(json)).toList();