import 'package:flutter/material.dart';
import 'meayar_colors.dart';
import 'meayar_shapes.dart';
import 'meayar_typography.dart';

/// Complete theme data bundle for MEAYAR Design System.
/// Implements [ThemeExtension] to allow smooth Flutter theme transitions.
@immutable
class MeayarThemeData extends ThemeExtension<MeayarThemeData> {
  const MeayarThemeData({
    required this.colors,
    this.typography = const MeayarTypography(),
    this.shapes = const MeayarShapes(),
  });

  final MeayarColors colors;
  final MeayarTypography typography;
  final MeayarShapes shapes;

  bool get isDark => colors.isDark;

  static const MeayarThemeData light = MeayarThemeData(
    colors: MeayarColors.light,
  );

  static const MeayarThemeData dark = MeayarThemeData(
    colors: MeayarColors.dark,
  );

  @override
  MeayarThemeData copyWith({
    MeayarColors? colors,
    MeayarTypography? typography,
    MeayarShapes? shapes,
  }) {
    return MeayarThemeData(
      colors: colors ?? this.colors,
      typography: typography ?? this.typography,
      shapes: shapes ?? this.shapes,
    );
  }

  @override
  MeayarThemeData lerp(ThemeExtension<MeayarThemeData>? other, double t) {
    if (other is! MeayarThemeData) return this;
    return MeayarThemeData(
      colors: colors.lerp(other.colors, t),
      typography: typography.lerp(other.typography, t),
      shapes: shapes.lerp(other.shapes, t),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MeayarThemeData &&
        other.colors == colors &&
        other.typography == typography &&
        other.shapes == shapes;
  }

  @override
  int get hashCode => Object.hash(colors, typography, shapes);
}
