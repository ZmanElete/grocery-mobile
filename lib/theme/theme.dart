import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static ThemeData getTheme(Brightness brightness) {
    ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: const Color.fromARGB(255, 12, 76, 14),
        onPrimary: Colors.white,
        secondary: const Color.fromARGB(255, 255, 77, 4),
        onSecondary: Colors.black,
        tertiary: const Color.fromARGB(255, 86, 43, 0),
        onTertiary: Colors.white,
        error: Colors.red.shade600,
        onError: Colors.white,
        background: const Color.fromARGB(255, 235, 250, 239),
        onBackground: const Color.fromARGB(255, 5, 30, 6),

        // WIP
        surface: const Color.fromARGB(255, 100, 100, 100),
        onSurface: Colors.white,
      ),
      // primarySwatch: createMaterialColor(const Color.fromARGB(255, 12, 76, 14)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          textStyle: const TextStyle(fontSize: 20),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.only(left: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
    theme = theme.copyWith(
      iconTheme: IconThemeData(color: theme.primaryColor, size: 24),
    );
    return theme;
  }
}

///Pulled from https://blog.usejournal.com/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
