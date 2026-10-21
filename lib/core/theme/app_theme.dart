// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';


class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.warmCream,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary:   AppColors.primary,
      secondary: AppColors.gold,
      background: AppColors.warmCream,
      surface:   AppColors.white,
      error:     AppColors.error,
    ),

    // Poppins display for headings, Lato for body — matches logo personality
    textTheme: TextTheme(
      displayLarge:  GoogleFonts.playfairDisplay(fontSize: 30, fontWeight: FontWeight.w700, color: AppColors.primary),
      headlineLarge: GoogleFonts.playfairDisplay(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.textDark),
      headlineMedium:GoogleFonts.playfairDisplay(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textDark),
      titleLarge:    GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textDark),
      titleMedium:   GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
      bodyLarge:     GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textDark),
      bodyMedium:    GoogleFonts.lato(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
      bodySmall:     GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
      labelSmall:    GoogleFonts.lato(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textHint),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      iconTheme: const IconThemeData(color: AppColors.textDark),
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textDark,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        textStyle: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
        textStyle: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    ),

   cardTheme: CardThemeData(
  color: AppColors.white,
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
    side: BorderSide(color: Colors.brown.shade100, width: 0.5),
  ),
),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.brown.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.brown.shade200, width: 0.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      hintStyle: GoogleFonts.lato(color: AppColors.textHint, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textHint,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppColors.warmCream,
      selectedColor: AppColors.primary,
      labelStyle: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(color: Colors.brown.shade200, width: 0.5),
    ),
  );
}