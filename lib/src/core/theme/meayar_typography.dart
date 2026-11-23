import 'package:flutter/material.dart';

/// MEAYAR Official Typography Foundation.
/// Powered by Qomra Arabic font family.
@immutable
class MeayarTypography {
  /// The package containing the bundled font assets.
  static const String package = 'meayar_flutter';

  /// Default font family identifier including package scope.
  static const String defaultFontFamily = 'packages/meayar_flutter/Qomra';

  const MeayarTypography({
    this.fontFamily = defaultFontFamily,

    // Heading Scales
    this.headingXl = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w700, // Bold
      fontSize: 40.0,
      height: 48.0 / 40.0,
    ),
    this.headingLg = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w700,
      fontSize: 36.0,
      height: 44.0 / 36.0,
    ),
    this.headingMd = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w700,
      fontSize: 32.0,
      height: 40.0 / 32.0,
    ),
    this.headingSm = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w600, // SemiBold
      fontSize: 28.0,
      height: 36.0 / 28.0,
    ),
    this.headingXs = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w600,
      fontSize: 24.0,
      height: 32.0 / 24.0,
    ),
    this.heading2xs = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w500, // Medium
      fontSize: 20.0,
      height: 24.0 / 20.0,
    ),

    // Body / Text Scales
    this.textXl = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w400, // Regular
      fontSize: 20.0,
      height: 28.0 / 20.0,
    ),
    this.textLg = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w400,
      fontSize: 18.0,
      height: 28.0 / 18.0,
    ),
    this.textLgMedium = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w500,
      fontSize: 18.0,
      height: 28.0 / 18.0,
    ),
    this.textMd = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      height: 24.0 / 16.0,
    ),
    this.textMdMedium = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      height: 24.0 / 16.0,
    ),
    this.textMdBold = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      height: 24.0 / 16.0,
    ),
    this.textSm = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      height: 20.0 / 14.0,
    ),
    this.textSmMedium = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      height: 20.0 / 14.0,
    ),
    this.textSmBold = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w700,
      fontSize: 14.0,
      height: 20.0 / 14.0,
    ),
    this.textXs = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w400,
      fontSize: 12.0,
      height: 18.0 / 12.0,
    ),
    this.textXsMedium = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      height: 18.0 / 12.0,
    ),
    this.text2xs = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w400,
      fontSize: 10.0,
      height: 14.0 / 10.0,
    ),
    this.text2xsMedium = const TextStyle(
      fontFamily: 'Qomra',
      package: package,
      fontWeight: FontWeight.w500,
      fontSize: 10.0,
      height: 14.0 / 10.0,
    ),
  });

  final String fontFamily;

  // Headings
  final TextStyle headingXl;
  final TextStyle headingLg;
  final TextStyle headingMd;
  final TextStyle headingSm;
  final TextStyle headingXs;
  final TextStyle heading2xs;

  // Body
  final TextStyle textXl;
  final TextStyle textLg;
  final TextStyle textLgMedium;
  final TextStyle textMd;
  final TextStyle textMdMedium;
  final TextStyle textMdBold;
  final TextStyle textSm;
  final TextStyle textSmMedium;
  final TextStyle textSmBold;
  final TextStyle textXs;
  final TextStyle textXsMedium;
  final TextStyle text2xs;
  final TextStyle text2xsMedium;

  /// Apply a color to all typography tokens
  MeayarTypography applyColor(Color color) {
    return MeayarTypography(
      fontFamily: fontFamily,
      headingXl: headingXl.copyWith(color: color),
      headingLg: headingLg.copyWith(color: color),
      headingMd: headingMd.copyWith(color: color),
      headingSm: headingSm.copyWith(color: color),
      headingXs: headingXs.copyWith(color: color),
      heading2xs: heading2xs.copyWith(color: color),
      textXl: textXl.copyWith(color: color),
      textLg: textLg.copyWith(color: color),
      textLgMedium: textLgMedium.copyWith(color: color),
      textMd: textMd.copyWith(color: color),
      textMdMedium: textMdMedium.copyWith(color: color),
      textMdBold: textMdBold.copyWith(color: color),
      textSm: textSm.copyWith(color: color),
      textSmMedium: textSmMedium.copyWith(color: color),
      textSmBold: textSmBold.copyWith(color: color),
      textXs: textXs.copyWith(color: color),
      textXsMedium: textXsMedium.copyWith(color: color),
      text2xs: text2xs.copyWith(color: color),
      text2xsMedium: text2xsMedium.copyWith(color: color),
    );
  }

  /// Maps Syrian typography to standard Material 3 TextTheme
  TextTheme toMaterialTextTheme({Color? color}) {
    final base = color != null ? applyColor(color) : this;
    return TextTheme(
      displayLarge: base.headingXl,
      displayMedium: base.headingLg,
      displaySmall: base.headingMd,
      headlineLarge: base.headingSm,
      headlineMedium: base.headingXs,
      headlineSmall: base.heading2xs,
      titleLarge: base.textXl,
      titleMedium: base.textLgMedium,
      titleSmall: base.textMdMedium,
      bodyLarge: base.textMd,
      bodyMedium: base.textSm,
      bodySmall: base.textXs,
      labelLarge: base.textSmMedium,
      labelMedium: base.textXsMedium,
      labelSmall: base.text2xs,
    );
  }

  MeayarTypography lerp(MeayarTypography? other, double t) {
    if (other == null) return this;
    return MeayarTypography(
      fontFamily: t < 0.5 ? fontFamily : other.fontFamily,
      headingXl: TextStyle.lerp(headingXl, other.headingXl, t)!,
      headingLg: TextStyle.lerp(headingLg, other.headingLg, t)!,
      headingMd: TextStyle.lerp(headingMd, other.headingMd, t)!,
      headingSm: TextStyle.lerp(headingSm, other.headingSm, t)!,
      headingXs: TextStyle.lerp(headingXs, other.headingXs, t)!,
      heading2xs: TextStyle.lerp(heading2xs, other.heading2xs, t)!,
      textXl: TextStyle.lerp(textXl, other.textXl, t)!,
      textLg: TextStyle.lerp(textLg, other.textLg, t)!,
      textLgMedium: TextStyle.lerp(textLgMedium, other.textLgMedium, t)!,
      textMd: TextStyle.lerp(textMd, other.textMd, t)!,
      textMdMedium: TextStyle.lerp(textMdMedium, other.textMdMedium, t)!,
      textMdBold: TextStyle.lerp(textMdBold, other.textMdBold, t)!,
      textSm: TextStyle.lerp(textSm, other.textSm, t)!,
      textSmMedium: TextStyle.lerp(textSmMedium, other.textSmMedium, t)!,
      textSmBold: TextStyle.lerp(textSmBold, other.textSmBold, t)!,
      textXs: TextStyle.lerp(textXs, other.textXs, t)!,
      textXsMedium: TextStyle.lerp(textXsMedium, other.textXsMedium, t)!,
      text2xs: TextStyle.lerp(text2xs, other.text2xs, t)!,
      text2xsMedium: TextStyle.lerp(text2xsMedium, other.text2xsMedium, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MeayarTypography &&
        other.fontFamily == fontFamily &&
        other.headingXl == headingXl &&
        other.headingLg == headingLg &&
        other.headingMd == headingMd &&
        other.headingSm == headingSm &&
        other.headingXs == headingXs &&
        other.heading2xs == heading2xs &&
        other.textXl == textXl &&
        other.textLg == textLg &&
        other.textLgMedium == textLgMedium &&
        other.textMd == textMd &&
        other.textMdMedium == textMdMedium &&
        other.textMdBold == textMdBold &&
        other.textSm == textSm &&
        other.textSmMedium == textSmMedium &&
        other.textSmBold == textSmBold &&
        other.textXs == textXs &&
        other.textXsMedium == textXsMedium &&
        other.text2xs == text2xs &&
        other.text2xsMedium == text2xsMedium;
  }

  @override
  int get hashCode => Object.hashAll([
        fontFamily,
        headingXl,
        headingLg,
        headingMd,
        headingSm,
        headingXs,
        heading2xs,
        textXl,
        textLg,
        textLgMedium,
        textMd,
        textMdMedium,
        textMdBold,
        textSm,
        textSmMedium,
        textSmBold,
        textXs,
        textXsMedium,
        text2xs,
        text2xsMedium,
      ]);
}
