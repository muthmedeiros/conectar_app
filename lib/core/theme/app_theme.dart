import 'package:flutter/material.dart';

import 'tokens/colors.dart';
import 'tokens/radius.dart';
import 'tokens/spacing.dart';
import 'tokens/typography.dart';

class AppTheme {
  static ThemeData light() {
    final cs = ColorScheme.fromSeed(
      seedColor: TColors.primary,
      brightness: Brightness.light,
      primary: TColors.primary,
      secondary: TColors.secondary,
      tertiary: TColors.tertiary,
      surface: TColors.surface,
      error: TColors.error,
      onPrimary: TColors.onPrimary,
      onSecondary: TColors.onSecondary,
      onTertiary: TColors.onTertiary,
      onSurface: TColors.onSurface,
      onError: TColors.onError,
      outline: TColors.outline,
      outlineVariant: TColors.outlineVariant,
      surfaceContainerHigh: TColors.surfaceVariant,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      textTheme: TTypography.lightTextTheme(),
      scaffoldBackgroundColor: TColors.background,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: TSpacing.md, vertical: TSpacing.sm),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TRadius.sm),
          borderSide: BorderSide(color: TColors.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TRadius.sm),
          borderSide: BorderSide(color: TColors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TRadius.sm),
          borderSide: BorderSide(color: TColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TRadius.sm),
          borderSide: BorderSide(color: TColors.error),
        ),
        fillColor: TColors.surfaceVariant,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: TColors.primary,
          foregroundColor: TColors.onPrimary,
          disabledBackgroundColor: TColors.neutral4,
          disabledForegroundColor: TColors.neutral7,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.sm)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.surface,
          foregroundColor: TColors.primary,
          side: BorderSide(color: TColors.outline),
          disabledBackgroundColor: TColors.neutral3,
          disabledForegroundColor: TColors.neutral6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.sm)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: TColors.primary,
          disabledForegroundColor: TColors.neutral6,
        ),
      ),
      cardTheme: CardThemeData(
        color: TColors.surface,
        surfaceTintColor: TColors.surfaceVariant,
        shadowColor: TColors.neutral5.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.md)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: TColors.surface,
        foregroundColor: TColors.onSurface,
        surfaceTintColor: TColors.surfaceVariant,
        shadowColor: TColors.neutral5.withOpacity(0.1),
      ),
    );
  }

  static ThemeData dark() {
    final cs = ColorScheme.fromSeed(
      seedColor: TColors.primary,
      brightness: Brightness.dark,
      primary: TColors.primary,
      secondary: TColors.secondary,
      tertiary: TColors.tertiary,
      surface: TColors.surfaceDark,
      error: TColors.error,
      onPrimary: TColors.onPrimary,
      onSecondary: TColors.onSecondary,
      onTertiary: TColors.onTertiary,
      onSurface: TColors.onSurfaceDark,
      onError: TColors.onError,
      outline: TColors.outlineDark,
      outlineVariant: TColors.outlineVariantDark,
      surfaceContainerHigh: TColors.surfaceContainerHigh,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      textTheme: TTypography.darkTextTheme(),
      scaffoldBackgroundColor: TColors.backgroundDark,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: TSpacing.md, vertical: TSpacing.sm),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TRadius.sm),
          borderSide: BorderSide(color: TColors.outlineDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TRadius.sm),
          borderSide: BorderSide(color: TColors.outlineDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TRadius.sm),
          borderSide: BorderSide(color: TColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TRadius.sm),
          borderSide: BorderSide(color: TColors.error),
        ),
        fillColor: TColors.surfaceVariantDark,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: TColors.primary,
          foregroundColor: TColors.onPrimary,
          disabledBackgroundColor: TColors.neutral8,
          disabledForegroundColor: TColors.neutral6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.sm)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.surfaceDark,
          foregroundColor: TColors.primary,
          side: BorderSide(color: TColors.outlineDark),
          disabledBackgroundColor: TColors.neutral9,
          disabledForegroundColor: TColors.neutral7,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.sm)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: TColors.primary,
          disabledForegroundColor: TColors.neutral7,
        ),
      ),
      cardTheme: CardThemeData(
        color: TColors.surfaceDark,
        surfaceTintColor: TColors.surfaceVariantDark,
        shadowColor: TColors.neutral100.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.md)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: TColors.surfaceDark,
        foregroundColor: TColors.onSurfaceDark,
        surfaceTintColor: TColors.surfaceVariantDark,
        shadowColor: TColors.neutral100.withOpacity(0.2),
      ),
    );
  }
}
