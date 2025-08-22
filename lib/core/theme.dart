import 'package:flutter/material.dart';

class PaperbackTheme {
  // Color Palette
  static const Color primaryRed = Color(0xFFFF6C6C);
  static const Color primaryGradientStart = Color(0xFFFF6C6C);
  static const Color primaryGradientEnd = Color(0xFFD65050);
  static const Color yellow = Color(0xFFFFF504);
  static const Color textSubtle = Color(0xFFF5F5F5);
  static const Color bgDark = Color(0xFF292731);
  static const Color bgDarker = Color(0xFF16151B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFFCEC6C6);

  // Primary Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGradientStart, primaryGradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Custom ColorScheme
  static const ColorScheme _colorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryRed,
    onPrimary: white,
    secondary: yellow,
    onSecondary: bgDark,
    tertiary: textDark,
    onTertiary: white,
    error: Color(0xFFCF6679),
    onError: white,
    surface: bgDark,
    onSurface: white,
    outline: textDark,
    shadow: Color(0xFF000000),
    inverseSurface: white,
    onInverseSurface: bgDark,
    inversePrimary: primaryRed,
    surfaceContainerHighest: bgDark,
    onSurfaceVariant: textSubtle,
  );

  // Custom Text Theme
  static TextTheme get textTheme {
    return const TextTheme(
      // Heading one - 28px, Newsreader display, Medium
      displayLarge: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: primaryRed,
        letterSpacing: -0.5,
      ),

      // Heading two - 24px, Newsreader display, Medium
      displayMedium: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: white,
        letterSpacing: -0.3,
      ),

      // Heading three - 20px, Newsreader display, Medium
      displaySmall: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
        letterSpacing: -0.2,
      ),

      // Heading four - 16px, Newsreader display, Medium
      headlineLarge: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: white,
      ),

      // Heading five - 12px, Karla, Bold
      headlineMedium: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: white,
        letterSpacing: 0.5,
      ),

      // Body medium - 14px, Karla, Regular
      bodyMedium: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: white,
        letterSpacing: 0.25,
      ),

      // Body small - 12px, Karla, Regular
      bodySmall: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textDark,
        letterSpacing: 0.4,
      ),

      // Additional text styles
      titleLarge: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: white,
      ),

      titleMedium: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: white,
      ),

      titleSmall: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textDark,
      ),

      labelLarge: TextStyle(
        fontFamily: 'sans-serif',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: white,
        letterSpacing: 0.1,
      ),

      labelMedium: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textDark,
        letterSpacing: 0.5,
      ),

      labelSmall: TextStyle(
        fontFamily: 'Newsreader',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textDark,
        letterSpacing: 0.5,
      ),
    );
  }

  // Main Theme Data
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: bgDark,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: bgDark,
        foregroundColor: white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Newsreader',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: white,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Newsreader',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: bgDark,
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bgDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryRed, width: 2),
        ),
        labelStyle: const TextStyle(color: textDark),
        hintStyle: const TextStyle(color: textDark),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bgDarker,
        selectedItemColor: primaryRed,
        unselectedItemColor: textDark,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: white, size: 24),

      // Divider Theme
      dividerTheme: const DividerThemeData(color: textDark, thickness: 0.5),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryRed,
        foregroundColor: white,
        elevation: 6,
      ),

      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return white;
          }
          return textDark;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryRed;
          }
          return bgDark;
        }),
      ),
    );
  }

  // Light theme variant (optional)
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primaryRed,
        onPrimary: white,
        secondary: yellow,
        onSecondary: bgDark,
        tertiary: bgDark,
        onTertiary: white,
        error: Color(0xFFB00020),
        onError: white,
        surface: white,
        onSurface: bgDark,

        outline: textDark,
        shadow: Color(0xFF000000),
        inverseSurface: bgDark,
        onInverseSurface: white,
        inversePrimary: primaryRed,
        surfaceContainerHighest: textSubtle,
        onSurfaceVariant: bgDark,
      ),
      textTheme: textTheme.apply(bodyColor: bgDark, displayColor: bgDark),
      scaffoldBackgroundColor: textSubtle,
    );
  }
}

// Extension for custom colors
extension PaperbackColors on ColorScheme {
  Color get primaryGradientStart => PaperbackTheme.primaryGradientStart;
  Color get primaryGradientEnd => PaperbackTheme.primaryGradientEnd;
  Color get yellow => PaperbackTheme.yellow;
  Color get textSubtle => PaperbackTheme.textSubtle;
  Color get bgDark => PaperbackTheme.bgDark;
  Color get bgDarker => PaperbackTheme.bgDarker;
  Color get textDark => PaperbackTheme.textDark;
}

// Extension for custom gradients
extension PaperbackGradients on ThemeData {
  LinearGradient get primaryGradient => PaperbackTheme.primaryGradient;
}