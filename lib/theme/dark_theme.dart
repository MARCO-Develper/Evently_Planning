import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c13_friday/theme/theme.dart';

class DarkTheme extends BaseTheme {
  @override
  Color get backgroundColor => Color(0xFF101127);

  @override
  Color get primaryColor => Color(0xFF5669FF);

  @override
  Color get textColor => Color(0xFFF4EBDC);

  @override
  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,

        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(
                color: Colors.white,
                width: 4
            )
        )
    ),
        appBarTheme:
            AppBarTheme(centerTitle: true, backgroundColor: backgroundColor),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          unselectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: backgroundColor,
        ),
        focusColor: primaryColor,
        textTheme: TextTheme(
          titleSmall: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      );
}
