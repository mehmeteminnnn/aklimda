import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'ComicNeue',
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontFamily: 'ComicNeue', fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontFamily: 'Quicksand'),
      labelLarge:
          TextStyle(fontFamily: 'ComicNeue', fontWeight: FontWeight.bold),
    ),
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 16,
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
