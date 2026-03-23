import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Pastel Theme Colors
const Color kPrimary = Color(0xFFB39DDB); // Light Purple
const Color kAccent = Color(0xFF80DEEA); // Light Cyan
const Color kBackground = Color(0xFFFFFFFF); // Pure white
const Color kSurface = Color(0xFFF1F8E9); // Light Greenish Grey
const Color kCard = Color(0xFFFFFFFF); // White
const Color kText = Color(0xFF0D0D0D); // Black
const Color kTextSecondary = Color(0xFF4B4B4B); // Dark grey
const Color kDivider = Color(0xFFE5E7EB); // Subtle border
const Color kError = Color(0xFFE53935); // Google Red

const Gradient kMainGradient = LinearGradient(
  colors: [kPrimary, kAccent],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

BoxDecoration modernCardDecoration({double radius = 16, Color? color}) =>
    BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: color ?? kCard,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.08 * 255).toInt()),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(color: kDivider, width: 1.2),
    );

// Modern ThemeData
ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: kPrimary,
    onPrimary: Colors.white,
    secondary: kAccent,
    onSecondary: Colors.white,
    surface: kSurface,
    onSurface: kText,
    error: kError,
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: kSurface,
  cardColor: kCard,
  dividerColor: kDivider,
  shadowColor: Colors.black.withAlpha((0.08 * 255).toInt()),
  // Use Google Fonts to avoid requiring local font files in assets/fonts/
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    displayLarge: const TextStyle(
        fontSize: 38,
        fontWeight: FontWeight.bold,
        color: kText,
        letterSpacing: -1.2),
    displayMedium: const TextStyle(
        fontSize: 30, fontWeight: FontWeight.bold, color: kText),
    headlineLarge: const TextStyle(
        fontSize: 26, fontWeight: FontWeight.bold, color: kText),
    headlineMedium: const TextStyle(
        fontSize: 22, fontWeight: FontWeight.w700, color: kText),
    titleLarge: const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w700, color: kText),
    titleMedium: const TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: kTextSecondary),
    bodyLarge: const TextStyle(
        fontSize: 17, fontWeight: FontWeight.w500, color: kText),
    bodyMedium: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.normal, color: kTextSecondary),
    labelLarge: const TextStyle(
        fontSize: 15, fontWeight: FontWeight.w700, color: kPrimary),
    labelMedium: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w500, color: kTextSecondary),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimary,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    centerTitle: true,
    surfaceTintColor: kPrimary,
    toolbarHeight: 64,
  ),
  cardTheme: CardThemeData(
    color: kCard,
    elevation: 4,
    margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      side: BorderSide(color: kDivider, width: 1.2),
    ),
    shadowColor: Colors.black.withAlpha((0.08 * 255).toInt()),
    surfaceTintColor: kCard,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimary,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: 3,
      shadowColor: Colors.black.withAlpha((0.08 * 255).toInt()),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: kSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: kDivider),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: kDivider),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      borderSide: BorderSide(color: kPrimary, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
    hintStyle: TextStyle(color: kTextSecondary, fontSize: 15),
    labelStyle: TextStyle(color: kPrimary, fontWeight: FontWeight.w700),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: kBackground,
    selectedItemColor: kPrimary,
    unselectedItemColor: kTextSecondary,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 10,
    selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
  ),
);
