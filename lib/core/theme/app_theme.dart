import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.cardBg,
        onPrimary: AppColors.textWhite,
        onSurface: AppColors.textDark,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textDark,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.textDark,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBg,
        selectedItemColor: AppColors.navSelected,
        unselectedItemColor: AppColors.navUnselected,
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 10,
          fontFamily: 'Poppins',
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: const TextStyle(
          color: AppColors.textLight,
          fontSize: 14,
          fontFamily: 'Poppins',
        ),
        prefixIconColor: AppColors.textLight,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 2,
        shadowColor: AppColors.primary.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedColor: AppColors.primary,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Poppins',
          color: AppColors.textMedium,
        ),
        secondaryLabelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Poppins',
          color: AppColors.textWhite,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide.none,
      ),
    );
  }
}
