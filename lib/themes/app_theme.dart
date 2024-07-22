import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF1A5F7A),
      primary: Color.fromARGB(255, 1, 216, 231),
      secondary: Color.fromARGB(255, 232, 163, 89),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Color(0xFF333333),
    ),
    scaffoldBackgroundColor: Color.fromARGB(255, 178, 187, 190),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xFF333333),
      ),
      bodyMedium: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: Color(0xFF333333),
      ),
      bodySmall: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        color: Color(0xFF333333),
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFF79327),
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );

  static BoxDecoration get gradientBackground => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color(0xFF1A5F7A), Color(0xFF57C5B6)],
    ),
  );

  static BoxDecoration get dottedBackground => BoxDecoration(
    color: Colors.white,
    backgroundBlendMode: BlendMode.difference,
    image: DecorationImage(
      image: AssetImage('assets/dot_pattern.png'),
      repeat: ImageRepeat.repeat,
    ),
  );
}