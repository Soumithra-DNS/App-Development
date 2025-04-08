import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/pages/home_page.dart';

/// Entry point of the application.
void main() {
  runApp(const MyApp());
}

/// Root widget of the Shopping App.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Providing global state for cart using Provider package.
      providers: [ChangeNotifierProvider(create: (ctx) => CartProvider())],

      child: MaterialApp(
        title: 'Shopping App',

        // App-wide theme customization
        theme: ThemeData(
          fontFamily: 'Lato',

          // Custom color scheme using seed color
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 220, 62),
            primary: const Color.fromARGB(255, 255, 220, 62),
          ),

          // Custom app bar styling
          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),

          // Default styling for input fields
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          // Custom text styles used across the app
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          // Enables Material 3 styling features
          useMaterial3: true,
        ),

        // Home page of the app
        home: const HomePage(),
      ),
    );
  }
}
