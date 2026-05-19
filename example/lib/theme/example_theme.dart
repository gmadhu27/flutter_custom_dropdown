import 'package:flutter/material.dart';

class ExampleTheme {
  const ExampleTheme._();

  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF002A86)),
      fontFamily: 'SF Pro Display',
      scaffoldBackgroundColor: const Color(0xFFF8F8FB),
      useMaterial3: true,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF8EA8FF),
        brightness: Brightness.dark,
      ),
      fontFamily: 'SF Pro Display',
      scaffoldBackgroundColor: const Color(0xFF101116),
      useMaterial3: true,
    );
  }
}
