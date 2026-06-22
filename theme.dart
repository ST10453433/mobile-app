// lib/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kBackground = Color(0xFFFDF2F4);
const kCard       = Color(0xFFFFFFFF);
const kPrimary    = Color(0xFFE91E63);
const kPrimaryFg  = Color(0xFFFFFFFF);
const kSecondary  = Color(0xFFFCE4EC);
const kSecondaryFg= Color(0xFFAD1457);
const kAccent     = Color(0xFFF06292);
const kMuted      = Color(0xFFF5F5F5);
const kMutedFg    = Color(0xFF666666);
const kBorder     = Color(0xFFF8BBD9);
const kForeground = Color(0xFF1A1A1A);

ThemeData buildTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: kBackground,
    colorScheme: ColorScheme.fromSeed(
      seedColor: kPrimary,
      primary: kPrimary,
      secondary: kSecondary,
      surface: kCard,
      onPrimary: kPrimaryFg,
    ),
    textTheme: TextTheme(
      displayLarge:  GoogleFonts.playfairDisplay(fontSize: 48, fontWeight: FontWeight.w700, color: kForeground),
      displayMedium: GoogleFonts.playfairDisplay(fontSize: 36, fontWeight: FontWeight.w700, color: kForeground),
      displaySmall:  GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.w700, color: kForeground),
      headlineLarge: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700, color: kForeground),
      headlineMedium:GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w600, color: kForeground),
      headlineSmall: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w600, color: kForeground),
      titleLarge:    GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600, color: kForeground),
      titleMedium:   GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500, color: kForeground),
      titleSmall:    GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500, color: kForeground),
      bodyLarge:     GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w400, color: kForeground),
      bodyMedium:    GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w400, color: kMutedFg),
      bodySmall:     GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w400, color: kMutedFg),
      labelLarge:    GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: kForeground),
      labelMedium:   GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: kMutedFg),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: kForeground),
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 22, fontWeight: FontWeight.w700,
        color: kPrimary, fontStyle: FontStyle.italic,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimary,
        foregroundColor: kPrimaryFg,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: kPrimary,
        side: const BorderSide(color: kPrimary, width: 2),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kSecondary,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: kPrimary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDC2626)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFDC2626), width: 2),
      ),
      labelStyle: GoogleFonts.dmSans(color: kMutedFg, fontSize: 13),
      hintStyle:  GoogleFonts.dmSans(color: kMutedFg, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    cardTheme: CardThemeData(
      color: kCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: kBorder),
      ),
    ),
    dividerColor: kBorder,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kCard,
      selectedItemColor: kPrimary,
      unselectedItemColor: kMutedFg,
      selectedLabelStyle:   GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.dmSans(fontSize: 10),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
