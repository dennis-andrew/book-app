import 'package:book_app/bloc/address/address_event.dart';
import 'package:book_app/bloc/book_list/book_list_bloc.dart';
import 'package:book_app/bloc/cart/cart_bloc.dart';
import 'package:book_app/bloc/theme/theme_bloc.dart';
import 'package:book_app/views/login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'bloc/address/address_bloc.dart';
import 'bloc/theme/theme_state.dart';

Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const BookStoreApp());
}

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => BookListBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => AddressBloc()..add(FetchAddressesEvent()))
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            themeMode: state.themeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.amber,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.amber[700],
                elevation: 4,
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
                titleMedium: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.amber,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.amber[800],
                elevation: 4,
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[700],
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  foregroundColor: Colors.black
                ),
              ),
              textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                bodyLarge: TextStyle(fontSize: 18, color: Colors.white70),
                titleMedium: TextStyle(fontSize: 16, color: Colors.white54),
              ),
            ),
            home: const LoginPage(),
          );
        },
      ),
    );
  }
}
