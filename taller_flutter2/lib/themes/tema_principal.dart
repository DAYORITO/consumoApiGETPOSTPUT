import 'package:flutter/material.dart';

class MyThema {
  ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Color.fromARGB(255, 0, 25, 168),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 0, 25, 168),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 0, 25, 168),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 0, 25, 168),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 0, 25, 168),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 0, 25, 168),
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 0, 25, 168),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      ),
      cardTheme: const CardTheme(
        color: Color.fromARGB(255, 222, 236, 255),
      ),
    );
  }
}
