// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Brand — extracted from Paradise Cafe logo
  static const primary       = Color(0xFFE8823A); // sunset orange
  static const primaryLight  = Color(0xFFF0A060); // lighter orange
  static const primaryDark   = Color(0xFFC0602A); // pressed state
  static const primaryTint   = Color(0xFFFFF0E6); // chip backgrounds

  static const gold          = Color(0xFFF5A623); // logo gold text
  static const green         = Color(0xFF2D6A1F); // logo green badge
  static const deepRed       = Color(0xFFC0392B); // logo red accent

  // Backgrounds
  static const darkBrown     = Color(0xFF1A0A00); // splash screen
  static const darkCard      = Color(0xFF2C1300); // dark mode card
  static const warmCream     = Color(0xFFFFF8F2); // page background
  static const white         = Color(0xFFFFFFFF); // cards, bottom bar

  // Text
  static const textDark      = Color(0xFF1A0A00);
  static const textSecondary = Color(0xFF7A6050);
  static const textHint      = Color(0xFFB09A88);

  // Semantic
  static const success       = Color(0xFF27AE60);
  static const warning       = Color(0xFFF5A623);
  static const error         = Color(0xFFE74C3C);
  static const info          = Color(0xFF2980B9);
}