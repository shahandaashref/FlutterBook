import 'package:flutter/material.dart';

class MyPaperbackTheme {
  static const Color primaryRed = Color(0xFFFF6C6C);
  static const Color primaryGradientStart = Color(0xFFFF6C6C);
  static const Color primaryGradientEnd = Color(0xFFD65050);
  static const Color yellow = Color(0xFFFFF504);
  static const Color textSubtle = Color(0xFFF5F5F5);
  static const Color bgDark = Color(0xFF292731);
  static const Color bgDarker = Color(0xFF16151B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFFCEC6C6);

    static const ColorScheme colorScheme =ColorScheme(
      brightness: Brightness.dark,
      primary: primaryRed, 
      onPrimary: white,
      secondary: yellow,
      onSecondary: bgDark ,
      error: Color(0xFFCF6679), 
      onError: white,
      surface: bgDark,
      onSurface:white 
      );

      static TextTheme get textTheme{
        return TextTheme(
          displayLarge: TextStyle(
            fontSize:54,
            fontFamily:  'Newsreader',
            fontWeight: FontWeight.bold,
            color: primaryRed,
            ),

            displayMedium: TextStyle(
              fontSize: 24,
              fontFamily: 'Karla',
              color: white,
            ),
            displaySmall: TextStyle(
              fontSize: 14,
              color: textSubtle

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
        //fontFamily: 'Newsreader',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: white,
        letterSpacing: 0.25,
      ),

      // Body small - 12px, Karla, Regular
      bodySmall: TextStyle(
        //fontFamily: 'Newsreader',
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
      static ThemeData get theme{
        return ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          textTheme: textTheme,
          scaffoldBackgroundColor: bgDark,
          appBarTheme: AppBarTheme(
            backgroundColor: bgDarker,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontFamily:  'Newsreader',
              color: white,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryRed,
              padding: EdgeInsets.symmetric(horizontal: 60,vertical: 10),
              foregroundColor: white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10),
            ),
            textStyle: TextStyle(
              fontSize: 24,
              //fontFamily:  'Newsreader',
              color: white,
            )
          )),

          
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bgDarker,
        selectedItemColor: primaryRed,
        unselectedItemColor: textDark,
        //type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
navigationBarTheme: NavigationBarThemeData(
  backgroundColor: bgDarker,
  indicatorColor: primaryRed.withValues(alpha: 0.2), 
  labelTextStyle: WidgetStateProperty.all(
    TextStyle(fontSize: 12),
  ),
  iconTheme: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return IconThemeData(color: primaryRed); // لون الأيقونة المحددة
    }
    return IconThemeData(color: Colors.grey); // لون الأيقونة العادية
  }),
  surfaceTintColor: Colors.transparent,
),

// في الـ Theme العام:



        );
      }


  
}