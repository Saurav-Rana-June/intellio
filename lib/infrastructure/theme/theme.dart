import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Map<int, Color> swatch = {
//   50: const Color.fromRGBO(87, 179, 62, .1),
//   100: const Color.fromRGBO(87, 179, 62, .2),
//   200: const Color.fromRGBO(87, 179, 62, .3),
//   300: const Color.fromRGBO(87, 179, 62, .4),
//   400: const Color.fromRGBO(87, 179, 62, .5),
//   500: const Color.fromRGBO(87, 179, 62, .6),
//   600: const Color.fromRGBO(87, 179, 62, .7),
//   700: const Color.fromRGBO(87, 179, 62, .8),
//   800: const Color.fromRGBO(87, 179, 62, .9),
//   900: const Color.fromRGBO(87, 179, 62, 1),
// };

// MaterialColor primarySwatch = MaterialColor(0xFF2998CB, swatch);

Color white = const Color(0xFFFFFFFF);
Color primary = const Color(0xFFCE57D6);
Color secondary = const Color(0xFF47364B);

Color scaffoldLight = const Color(0xFFEBEBEB);
Color scaffoldDark = const Color(0xFF0D1114);

Color regular = const Color(0xFF01080D);
Color regular10 = const Color(0xFFEAEBED);
Color regular30 = const Color(0xFFBEC3C8);
Color regular50 = const Color(0xFF929BA2);

Color successColor = const Color(0xFF76BB70);
Color dangerColor = const Color(0xFFFF5C58);
Color warningColor = const Color(0xFFfea404);
Color infoColor = const Color(0xFF6CAAD8);

TextStyle h1 = GoogleFonts.jost(fontSize: 32, fontWeight: FontWeight.w600);

TextStyle h2 = GoogleFonts.jost(fontSize: 22, fontWeight: FontWeight.w600);

TextStyle r18 = GoogleFonts.jost(fontSize: 18, fontWeight: FontWeight.w400);

TextStyle r16 = GoogleFonts.jost(fontSize: 16, fontWeight: FontWeight.w400);

TextStyle r14 = GoogleFonts.jost(fontSize: 14, fontWeight: FontWeight.w400);

TextStyle r12 = GoogleFonts.jost(fontSize: 12, fontWeight: FontWeight.w400);

class AppTheme {
  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: white,
      displayColor: white,
    ),
    primaryColor: primary,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: scaffoldDark,
      // titleTextStyle: h2.copyWith(color: white),
      iconTheme: IconThemeData(color: white),
    ),
    listTileTheme: ListTileThemeData(textColor: white),
    scaffoldBackgroundColor: scaffoldDark,
    cardColor: regular,
    // colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch).copyWith(
    //   secondary: primary,
    //   brightness: Brightness.dark,
    // ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: primary,
      dividerColor: regular,
    ),
    dividerColor: white,
  );

// Light Theme
  static ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: regular,
      displayColor: regular,
    ),
    primaryColor: primary,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: scaffoldLight,
      // titleTextStyle: h2.copyWith(color: white),
      iconTheme: IconThemeData(color: regular),
    ),
    listTileTheme: ListTileThemeData(textColor: regular),
    scaffoldBackgroundColor: scaffoldLight,
    cardColor: regular,
    // colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch).copyWith(
    //   secondary: primary,
    //   brightness: Brightness.light,
    // ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: primary,
      dividerColor: regular,
    ),
    dividerColor: regular50,
  );
}
