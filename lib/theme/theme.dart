import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppTheme {
  static ThemeData getTheme(Brightness brightness) {
    const primary = const Color.fromARGB(255, 14, 95, 17);
    const lightenedPrimary = Color.fromARGB(255, 21, 138, 25);

    const background =  Color.fromARGB(255, 235, 250, 239);
    const darkBackground = Color.fromARGB(255, 55, 59, 55);

    const primaryContainer = const Color(0xFFEAF4F0);
    const onPrimaryContainer = primary;

    const onDark = Color(0xFFE1E9E3);
    const onLight = const Color.fromARGB(255, 0, 0, 0);

    const inverseSurface = Color.fromRGBO(65, 72, 65, 1);
    const darkInverseSurface =  onDark;

    const secondary = Color.fromARGB(255, 86, 43, 0);
    const darkSecondary = Color.fromARGB(255, 133, 67, 0);

    const surface = Color.fromARGB(255, 190, 225, 200);
    const darkSurface = Color.fromARGB(255, 46, 49, 46);

    final scheme = ColorScheme(
      brightness: brightness,

      primary: switch(brightness) {
        Brightness.light => primary,
        Brightness.dark => lightenedPrimary,
      },
      onPrimary: switch(brightness) {
        Brightness.light => Colors.white,
        Brightness.dark => onDark,
      },

      /// Used In:
      /// FAB's, Switches
      primaryContainer: switch (brightness) {
        Brightness.light => primaryContainer,
        Brightness.dark => onPrimaryContainer,
      },
      onPrimaryContainer: switch (brightness) {
        Brightness.light => onPrimaryContainer,
        Brightness.dark => primaryContainer,
      },

      // Shows in snackbar and icon buttons
      inverseSurface: switch (brightness) {
        Brightness.light => inverseSurface,
        Brightness.dark => darkInverseSurface,
      },
      onInverseSurface: switch (brightness) {
        Brightness.light => Colors.white,
        Brightness.dark => Colors.black,
      },

      /// Found only in snackbar on the action TextColor
      inversePrimary: switch (brightness) {
        Brightness.light => lightenedPrimary,
        Brightness.dark => primary,
      },

      // Only used when specified.
      secondary: switch (brightness) {
        Brightness.light => secondary,
        Brightness.dark => darkSecondary,
      },
      onSecondary: switch (brightness) {
        Brightness.light => Colors.white,
        Brightness.dark => Colors.white,
      },

      // Used in:
      // Bottom Nav
      // Chips on selected
      secondaryContainer: primary.withOpacity(.2),
      onSecondaryContainer: switch (brightness) {
        Brightness.light => onLight,
        Brightness.dark => onDark,
      },

      background: switch (brightness) {
        Brightness.light => background,
        Brightness.dark => darkBackground,
      },

      // Used In:
      // Anything that has an outline/border IE: Chips, Text Box, OutlinedButton
      // Dividers, drop down selection
      // Used in the Switch as the disabled color
      // There is a single line in the date picker that uses this over outline
      onBackground: switch (brightness) {
        Brightness.light => onLight,
        Brightness.dark => onDark.withOpacity(.6),
      },

      surface: switch (brightness) {
        Brightness.light => surface,
        Brightness.dark => darkSurface,
      },

      onSurface: switch (brightness) {
        Brightness.light => onLight,
        Brightness.dark => onDark,
      },

      // If not set, defaults to whites and greys
      // Used in:
      // Search Bar, Switcher, Time picker
      // surfaceVariant: switch (brightness) {
      //   Brightness.light => Colors.red,
      //   Brightness.dark => Colors.red,
      // },

      // If not set, uses a color that is very close to primary
      // Used in:
      // AppBar, Cards, Dialogs, etc
      // surfaceTint: switch (brightness) {
      //   Brightness.light => primary,
      //   Brightness.dark => primary,
      // },

      // If not set, Defaults to onBackground
      // Used in:
      // App Bar Button text, Drop Down Button Text, Expansion Tiles icons, etc
      // TextField label, Some Date Picker Text, General Icons?
      // onSurfaceVariant: switch (brightness) {
      //   Brightness.light => null,
      //   Brightness.dark => null,
      // },

      // If not set, defaults to onBackground
      //(overrides all of onBackground except for in 1 place so use onBackground instead)
      // outline: switch (brightness) {
      //   Brightness.light => Colors.orange,
      //   Brightness.dark => Colors.orange,
      // },

      // Defaults to onBackground
      // This color is only used for the divider.
      outlineVariant: switch (brightness) {
        // Made dividers more transparent than onBackground.
        // Brightness.light => onLight.withOpacity(.5),
        // Brightness.dark => onDark.withOpacity(.5),
        Brightness.light => const Color(0xFFEFEFEC),
        Brightness.dark => const Color(0xFF777776),
      },

      // Literally not used
      scrim: switch (brightness) {
        Brightness.light => Colors.black.withOpacity(.5),
        Brightness.dark => Colors.black.withOpacity(.5),
      },

      // Changes the color of the shadows throughout the app.
      // Defaults to black.
      // It's hard to notice on a lot of the widgets.
      //you can tell on elevated button and cards
      // shadow: switch (brightness) {
      //   Brightness.light => null,
      //   Brightness.dark => null,
      // },

      // Needs some testing
      error: switch (brightness) {
        Brightness.light => Colors.red[700]!,
        Brightness.dark => Colors.red,
      },

      onError: switch (brightness) {
        Brightness.light => onDark,
        Brightness.dark => onLight,
      },

      // Needs some testing
      errorContainer: switch (brightness) {
        Brightness.light => Colors.redAccent[100],
        Brightness.dark => Colors.redAccent[100],
      },
      onErrorContainer: switch (brightness) {
        Brightness.light => onDark,
        Brightness.dark => onDark,
      },


    );

    ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // primarySwatch: createMaterialColor(const Color.fromARGB(255, 12, 76, 14)),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          // textStyle: const TextStyle(fontSize: 20),
        ),
      ),
      appBarTheme: AppBarTheme(
        // backgroundColor: scheme.background,
        // surfaceTintColor: scheme.primary.withOpacity(1),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        focusColor: scheme.primary,
        labelStyle: TextStyle(color: scheme.primary),
        iconColor: scheme.primary,
        hintStyle: TextStyle(color: scheme.primary),
        helperStyle: TextStyle(color: scheme.primary),
        prefixStyle: TextStyle(color: scheme.primary),
        suffixStyle: TextStyle(color: scheme.primary),
        counterStyle: TextStyle(color: scheme.primary),
        floatingLabelStyle: TextStyle(color: scheme.primary),
        fillColor: scheme.primary,
        prefixIconColor: scheme.primary,
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
