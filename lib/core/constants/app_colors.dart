import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimary = Color(0xFF6366F1);
  static const Color lightPrimaryContainer = Color(0xFFEEF2FF);
  static const Color lightOnSurface = Color(0xFF1F2937);
  static const Color lightOnSurfaceVariant = Color(0xFF6B7280);
  static const Color lightOutline = Color(0xFFE5E7EB);
  static const Color lightOutlineVariant = Color(0xFFF9FAFB);
  static const Color lightShadow = Color(0xFF000000);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF111827);
  static const Color darkSurface = Color(0xFF1F2937);
  static const Color darkPrimary = Color(0xFF6366F1);
  static Color darkPrimaryContainer = Colors.blue.shade100;
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkOnSurfaceVariant = Color(0xFF9CA3AF);
  static const Color darkOutline = Color(0xFF374151);
  static const Color darkOutlineVariant = Color(0xFF4B5563);
  static const Color darkShadow = Color(0xFF000000);

  // Helper methods to get theme-aware colors
  static Color getBackgroundColor(bool isDark) {
    return isDark ? darkBackground : lightBackground;
  }

  static Color getSurfaceColor(bool isDark) {
    return isDark ? darkSurface : lightSurface;
  }

  static Color getPrimaryColor(bool isDark) {
    return isDark ? darkPrimary : lightPrimary;
  }

  static Color getPrimaryContainerColor(bool isDark) {
    return isDark ? darkPrimaryContainer : lightPrimaryContainer;
  }

  static Color getOnSurfaceColor(bool isDark) {
    return isDark ? darkOnSurface : lightOnSurface;
  }

  static Color getOnSurfaceVariantColor(bool isDark) {
    return isDark ? darkOnSurfaceVariant : lightOnSurfaceVariant;
  }

  static Color getOutlineColor(bool isDark) {
    return isDark ? darkOutline : lightOutline;
  }

  static Color getOutlineVariantColor(bool isDark) {
    return isDark ? darkOutlineVariant : lightOutlineVariant;
  }

  static Color getShadowColor(bool isDark) {
    return isDark ? darkShadow : lightShadow;
  }

  static Color getShadowColorWithOpacity(bool isDark, double opacity) {
    return isDark
        ? darkShadow.withOpacity(opacity)
        : lightShadow.withOpacity(opacity);
  }
}
