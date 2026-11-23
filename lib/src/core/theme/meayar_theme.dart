import 'package:flutter/material.dart';
import 'meayar_colors.dart';
import 'meayar_shapes.dart';
import 'meayar_theme_data.dart';
import 'meayar_typography.dart';

/// Entry point to the MEAYAR (معيار) Design System for Flutter.
class MeayarTheme extends StatelessWidget {
  const MeayarTheme({
    super.key,
    required this.data,
    required this.child,
  });

  final MeayarThemeData data;
  final Widget child;

  /// Retrieves the current [MeayarThemeData] from the widget tree.
  static MeayarThemeData of(BuildContext context) {
    // 1. Try finding from InheritedWidget
    final inherited = context.dependOnInheritedWidgetOfExactType<_InheritedMeayarTheme>();
    if (inherited != null) {
      return inherited.data;
    }

    // 2. Try finding from ThemeData extensions
    final extension = Theme.of(context).extension<MeayarThemeData>();
    if (extension != null) {
      return extension;
    }

    // 3. Fallback based on system brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? MeayarThemeData.dark : MeayarThemeData.light;
  }

  /// Builds a complete Material 3 [ThemeData] mapped to Syrian visual tokens.
  static ThemeData createThemeData({
    Brightness brightness = Brightness.light,
    MeayarThemeData? meayarData,
  }) {
    final isDark = brightness == Brightness.dark;
    final meayar = meayarData ?? (isDark ? MeayarThemeData.dark : MeayarThemeData.light);
    final colors = meayar.colors;
    final typography = meayar.typography;
    final shapes = meayar.shapes;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.backgroundBrand,
      onPrimary: colors.textInverse,
      primaryContainer: colors.backgroundBrandSubtle,
      onPrimaryContainer: colors.textBrand,
      secondary: colors.backgroundBrand,
      onSecondary: colors.textInverse,
      secondaryContainer: colors.backgroundBrandSubtle,
      onSecondaryContainer: colors.textBrand,
      tertiary: MeayarPrimitives.syrianGold500,
      onTertiary: colors.textInverse,
      surface: colors.backgroundSurface,
      onSurface: colors.textPrimary,
      surfaceContainerLowest: colors.backgroundPage,
      surfaceContainerLow: colors.backgroundSubtle,
      surfaceContainer: colors.backgroundSurface,
      surfaceContainerHigh: colors.backgroundMuted,
      surfaceContainerHighest: colors.backgroundDisabled,
      outline: colors.borderDefault,
      outlineVariant: colors.borderSubtle,
      error: colors.backgroundError,
      onError: colors.textInverse,
      errorContainer: colors.backgroundErrorSubtle,
      onErrorContainer: colors.textError,
    );

    final textTheme = typography.toMaterialTextTheme(color: colors.textPrimary);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.backgroundPage,
      fontFamily: typography.fontFamily,
      textTheme: textTheme,
      extensions: [meayar],

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: colors.backgroundSurface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        titleTextStyle: typography.heading2xs.copyWith(color: colors.textPrimary),
        iconTheme: IconThemeData(color: colors.iconPrimary),
      ),

      // Card
      cardTheme: CardThemeData(
        color: colors.backgroundSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: shapes.medium,
          side: BorderSide(color: colors.borderSubtle, width: 1.0),
        ),
      ),

      // Buttons
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.backgroundBrand,
          foregroundColor: colors.textInverse,
          shape: shapes.mediumBorder,
          textStyle: typography.textSmMedium,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          elevation: 0,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.backgroundBrand,
          foregroundColor: colors.textInverse,
          shape: shapes.mediumBorder,
          textStyle: typography.textSmMedium,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.borderDefault, width: 1.0),
          shape: shapes.mediumBorder,
          textStyle: typography.textSmMedium,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.textBrand,
          shape: shapes.mediumBorder,
          textStyle: typography.textSmMedium,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.backgroundSubtle,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        hintStyle: typography.textSm.copyWith(color: colors.textDisabled),
        labelStyle: typography.textSmMedium.copyWith(color: colors.textSecondary),
        helperStyle: typography.textXs.copyWith(color: colors.textTertiary),
        errorStyle: typography.textXs.copyWith(color: colors.textError),
        border: OutlineInputBorder(
          borderRadius: shapes.medium,
          borderSide: BorderSide(color: colors.borderDefault, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: shapes.medium,
          borderSide: BorderSide(color: colors.borderDefault, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: shapes.medium,
          borderSide: BorderSide(color: colors.borderFocus, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: shapes.medium,
          borderSide: BorderSide(color: colors.borderError, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: shapes.medium,
          borderSide: BorderSide(color: colors.borderError, width: 1.5),
        ),
      ),

      // Checkbox, Radio, Switch
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: shapes.extraSmall),
        side: BorderSide(color: colors.borderStrong, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return colors.backgroundDisabled;
          if (states.contains(WidgetState.selected)) return colors.backgroundBrand;
          return Colors.transparent;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return colors.backgroundDisabled;
          if (states.contains(WidgetState.selected)) return colors.backgroundBrand;
          return colors.borderStrong;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return colors.textDisabled;
          if (states.contains(WidgetState.selected)) return colors.textInverse;
          return colors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return colors.backgroundDisabled;
          if (states.contains(WidgetState.selected)) return colors.backgroundBrand;
          return colors.backgroundMuted;
        }),
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: colors.borderSubtle,
        thickness: 1.0,
        space: 1.0,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: colors.backgroundSurface,
        shape: RoundedRectangleBorder(borderRadius: shapes.extraLarge),
        elevation: 4,
        titleTextStyle: typography.heading2xs.copyWith(color: colors.textPrimary),
        contentTextStyle: typography.textSm.copyWith(color: colors.textSecondary),
      ),

      // Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colors.backgroundSurface,
        indicatorColor: colors.backgroundBrandSubtle,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return typography.textXsMedium.copyWith(color: colors.textBrand);
          }
          return typography.textXs.copyWith(color: colors.textSecondary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colors.iconBrand);
          }
          return IconThemeData(color: colors.iconSecondary);
        }),
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.backgroundInverse,
        contentTextStyle: typography.textSm.copyWith(color: colors.textInverse),
        shape: RoundedRectangleBorder(borderRadius: shapes.medium),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedMeayarTheme(
      data: data,
      child: child,
    );
  }
}

class _InheritedMeayarTheme extends InheritedWidget {
  const _InheritedMeayarTheme({
    required this.data,
    required super.child,
  });

  final MeayarThemeData data;

  @override
  bool updateShouldNotify(_InheritedMeayarTheme oldWidget) => data != oldWidget.data;
}

/// Ergonomic extension on [BuildContext] for quick access to MEAYAR design tokens.
extension BuildContextMeayarX on BuildContext {
  MeayarThemeData get meayar => MeayarTheme.of(this);
  MeayarColors get meayarColors => meayar.colors;
  MeayarTypography get meayarTypography => meayar.typography;
  MeayarShapes get meayarShapes => meayar.shapes;
}
