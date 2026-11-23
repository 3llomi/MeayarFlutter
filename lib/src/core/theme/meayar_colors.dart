import 'package:flutter/material.dart';

/// MEAYAR (معيار) Raw Syrian State Identity Primitives.
class MeayarPrimitives {
  const MeayarPrimitives._();

  static const Color syrianGreen900 = Color(0xFF000606);
  static const Color syrianGreen700 = Color(0xFF001312);
  static const Color syrianGreen500 = Color(0xFF002623);
  static const Color syrianGreen400 = Color(0xFF094239); // Main Syrian Brand Green
  static const Color syrianGreen300 = Color(0xFF427F77);
  static const Color syrianGreen200 = Color(0xFF3B877B);
  static const Color syrianGreen100 = Color(0xFF53A99C);
  static const Color syrianGreen0 = Color(0xFFD8DFDE);

  static const Color syrianGold800 = Color(0xFF4D4532);
  static const Color syrianGold700 = Color(0xFF706649);
  static const Color syrianGold500 = Color(0xFFB8A678);
  static const Color syrianGold400 = Color(0xFFC6B893);
  static const Color syrianGold300 = Color(0xFFD4CAAE);
  static const Color syrianGold200 = Color(0xFFE3DBC9);
  static const Color syrianGold0 = Color(0xFFFFFFFF);

  static const Color red600 = Color(0xFFCC2A1E);
  static const Color red500 = Color(0xFFEB3B2F);
  static const Color red400 = Color(0xFFF97066);
  static const Color red50 = Color(0xFFFEF3F2);

  static const Color green700 = Color(0xFF274A12);
  static const Color green600 = Color(0xFF367311);
  static const Color green400 = Color(0xFF61FF00);
  static const Color green50 = Color(0xFFF2FFEB);

  static const Color blue600 = Color(0xFF167BD9);
  static const Color blue400 = Color(0xFF2697FF);
  static const Color blue50 = Color(0xFFEBF5FF);

  static const Color neutral900 = Color(0xFF0D0D12);
  static const Color neutral800 = Color(0xFF1A1B25);
  static const Color neutral700 = Color(0xFF272835);
  static const Color neutral600 = Color(0xFF36394A);
  static const Color neutral500 = Color(0xFF666D80);
  static const Color neutral400 = Color(0xFF818898);
  static const Color neutral300 = Color(0xFFA4ACB9);
  static const Color neutral200 = Color(0xFFC1C7D0);
  static const Color neutral100 = Color(0xFFDFE1E7);
  static const Color neutral50 = Color(0xFFECEFF3);
  static const Color neutral25 = Color(0xFFF6F8FA);
  static const Color white = Color(0xFFFFFFFF);
}

/// Semantic color tokens for the MEAYAR Design System.
@immutable
class MeayarColors {
  const MeayarColors({
    // Text Semantic Tokens
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.textInverse,
    required this.textBrand,
    required this.textError,
    required this.textSuccess,
    required this.textWarning,
    required this.textInfo,

    // Background Semantic Tokens
    required this.backgroundPage,
    required this.backgroundSurface,
    required this.backgroundSubtle,
    required this.backgroundMuted,
    required this.backgroundInverse,
    required this.backgroundDisabled,
    required this.backgroundBrand,
    required this.backgroundBrandHover,
    required this.backgroundBrandSubtle,
    required this.backgroundError,
    required this.backgroundErrorSubtle,
    required this.backgroundSuccessSubtle,
    required this.backgroundWarningSubtle,
    required this.backgroundInfoSubtle,

    // Border Semantic Tokens
    required this.borderDefault,
    required this.borderSubtle,
    required this.borderStrong,
    required this.borderBrand,
    required this.borderError,
    required this.borderFocus,

    // Icon Semantic Tokens
    required this.iconPrimary,
    required this.iconSecondary,
    required this.iconDisabled,
    required this.iconBrand,
    required this.iconInverse,

    // Tag / Status Palettes
    required this.tagPrimaryBackground,
    required this.tagPrimaryText,
    required this.tagGreenBackground,
    required this.tagGreenText,
    required this.tagRedBackground,
    required this.tagRedText,
    required this.tagYellowBackground,
    required this.tagYellowText,
    required this.tagGoldBackground,
    required this.tagGoldText,
    required this.tagBlueBackground,
    required this.tagBlueText,
    required this.tagGrayBackground,
    required this.tagGrayText,

    required this.isDark,
  });

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textDisabled;
  final Color textInverse;
  final Color textBrand;
  final Color textError;
  final Color textSuccess;
  final Color textWarning;
  final Color textInfo;

  // Background
  final Color backgroundPage;
  final Color backgroundSurface;
  final Color backgroundSubtle;
  final Color backgroundMuted;
  final Color backgroundInverse;
  final Color backgroundDisabled;
  final Color backgroundBrand;
  final Color backgroundBrandHover;
  final Color backgroundBrandSubtle;
  final Color backgroundError;
  final Color backgroundErrorSubtle;
  final Color backgroundSuccessSubtle;
  final Color backgroundWarningSubtle;
  final Color backgroundInfoSubtle;

  // Border
  final Color borderDefault;
  final Color borderSubtle;
  final Color borderStrong;
  final Color borderBrand;
  final Color borderError;
  final Color borderFocus;

  // Icon
  final Color iconPrimary;
  final Color iconSecondary;
  final Color iconDisabled;
  final Color iconBrand;
  final Color iconInverse;

  // Tags
  final Color tagPrimaryBackground;
  final Color tagPrimaryText;
  final Color tagGreenBackground;
  final Color tagGreenText;
  final Color tagRedBackground;
  final Color tagRedText;
  final Color tagYellowBackground;
  final Color tagYellowText;
  final Color tagGoldBackground;
  final Color tagGoldText;
  final Color tagBlueBackground;
  final Color tagBlueText;
  final Color tagGrayBackground;
  final Color tagGrayText;

  final bool isDark;

  static const MeayarColors light = MeayarColors(
    textPrimary: Color(0xFF0D0D12),
    textSecondary: Color(0xFF36394A),
    textTertiary: Color(0xFF666D80),
    textDisabled: Color(0xFFA4ACB9),
    textInverse: Color(0xFFFFFFFF),
    textBrand: Color(0xFF094239),
    textError: Color(0xFFCC2A1E),
    textSuccess: Color(0xFF367311),
    textWarning: Color(0xFF4A3204),
    textInfo: Color(0xFF167BD9),

    backgroundPage: Color(0xFFFFFFFF),
    backgroundSurface: Color(0xFFFFFFFF),
    backgroundSubtle: Color(0xFFF6F8FA),
    backgroundMuted: Color(0xFFECEFF3),
    backgroundInverse: Color(0xFF0D0D12),
    backgroundDisabled: Color(0xFFDFE1E7),
    backgroundBrand: Color(0xFF094239),
    backgroundBrandHover: Color(0xFF002623),
    backgroundBrandSubtle: Color(0xFFD8DFDE),
    backgroundError: Color(0xFFCC2A1E),
    backgroundErrorSubtle: Color(0xFFFEF3F2),
    backgroundSuccessSubtle: Color(0xFFF2FFEB),
    backgroundWarningSubtle: Color(0xFFFAE9C8),
    backgroundInfoSubtle: Color(0xFFEBF5FF),

    borderDefault: Color(0xFFC1C7D0),
    borderSubtle: Color(0xFFDFE1E7),
    borderStrong: Color(0xFF818898),
    borderBrand: Color(0xFF094239),
    borderError: Color(0xFFF97066),
    borderFocus: Color(0xFF094239),

    iconPrimary: Color(0xFF0D0D12),
    iconSecondary: Color(0xFF666D80),
    iconDisabled: Color(0xFFA4ACB9),
    iconBrand: Color(0xFF094239),
    iconInverse: Color(0xFFFFFFFF),

    tagPrimaryBackground: Color(0xFFD8DFDE),
    tagPrimaryText: Color(0xFF094239),
    tagGreenBackground: Color(0xFFF2FFEB),
    tagGreenText: Color(0xFF367311),
    tagRedBackground: Color(0xFFFEF3F2),
    tagRedText: Color(0xFFCC2A1E),
    tagYellowBackground: Color(0xFFFAE9C8),
    tagYellowText: Color(0xFF4A3204),
    tagGoldBackground: Color(0xFFE3DBC9),
    tagGoldText: Color(0xFF706649),
    tagBlueBackground: Color(0xFFEBF5FF),
    tagBlueText: Color(0xFF167BD9),
    tagGrayBackground: Color(0xFFECEFF3),
    tagGrayText: Color(0xFF36394A),

    isDark: false,
  );

  static const MeayarColors dark = MeayarColors(
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFC1C7D0),
    textTertiary: Color(0xFFA4ACB9),
    textDisabled: Color(0xFF36394A),
    textInverse: Color(0xFF0D0D12),
    textBrand: Color(0xFF53A99C),
    textError: Color(0xFFF97066),
    textSuccess: Color(0xFF61FF00),
    textWarning: Color(0xFFF5B231),
    textInfo: Color(0xFF2697FF),

    backgroundPage: Color(0xFF0D0D12),
    backgroundSurface: Color(0xFF1A1B25),
    backgroundSubtle: Color(0xFF1A1B25),
    backgroundMuted: Color(0xFF272835),
    backgroundInverse: Color(0xFFFFFFFF),
    backgroundDisabled: Color(0xFF272835),
    backgroundBrand: Color(0xFF3B877B),
    backgroundBrandHover: Color(0xFF53A99C),
    backgroundBrandSubtle: Color(0xFF001312),
    backgroundError: Color(0xFFEB3B2F),
    backgroundErrorSubtle: Color(0xFF330D07),
    backgroundSuccessSubtle: Color(0xFF274A12),
    backgroundWarningSubtle: Color(0xFF330D07),
    backgroundInfoSubtle: Color(0xFF0B2D4C),

    borderDefault: Color(0xFF272835),
    borderSubtle: Color(0xFF1A1B25),
    borderStrong: Color(0xFF666D80),
    borderBrand: Color(0xFF3B877B),
    borderError: Color(0xFFEB3B2F),
    borderFocus: Color(0xFF53A99C),

    iconPrimary: Color(0xFFFFFFFF),
    iconSecondary: Color(0xFFA4ACB9),
    iconDisabled: Color(0xFF36394A),
    iconBrand: Color(0xFF53A99C),
    iconInverse: Color(0xFF0D0D12),

    tagPrimaryBackground: Color(0xFF001312),
    tagPrimaryText: Color(0xFF53A99C),
    tagGreenBackground: Color(0xFF274A12),
    tagGreenText: Color(0xFF61FF00),
    tagRedBackground: Color(0xFF330D07),
    tagRedText: Color(0xFFF97066),
    tagYellowBackground: Color(0xFF330D07),
    tagYellowText: Color(0xFFF5B231),
    tagGoldBackground: Color(0xFF4D4532),
    tagGoldText: Color(0xFFC6B893),
    tagBlueBackground: Color(0xFF0B2D4C),
    tagBlueText: Color(0xFF2697FF),
    tagGrayBackground: Color(0xFF272835),
    tagGrayText: Color(0xFFC1C7D0),

    isDark: true,
  );

  MeayarColors lerp(MeayarColors? other, double t) {
    if (other == null) return this;
    return MeayarColors(
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      textBrand: Color.lerp(textBrand, other.textBrand, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      textWarning: Color.lerp(textWarning, other.textWarning, t)!,
      textInfo: Color.lerp(textInfo, other.textInfo, t)!,

      backgroundPage: Color.lerp(backgroundPage, other.backgroundPage, t)!,
      backgroundSurface: Color.lerp(backgroundSurface, other.backgroundSurface, t)!,
      backgroundSubtle: Color.lerp(backgroundSubtle, other.backgroundSubtle, t)!,
      backgroundMuted: Color.lerp(backgroundMuted, other.backgroundMuted, t)!,
      backgroundInverse: Color.lerp(backgroundInverse, other.backgroundInverse, t)!,
      backgroundDisabled: Color.lerp(backgroundDisabled, other.backgroundDisabled, t)!,
      backgroundBrand: Color.lerp(backgroundBrand, other.backgroundBrand, t)!,
      backgroundBrandHover: Color.lerp(backgroundBrandHover, other.backgroundBrandHover, t)!,
      backgroundBrandSubtle: Color.lerp(backgroundBrandSubtle, other.backgroundBrandSubtle, t)!,
      backgroundError: Color.lerp(backgroundError, other.backgroundError, t)!,
      backgroundErrorSubtle: Color.lerp(backgroundErrorSubtle, other.backgroundErrorSubtle, t)!,
      backgroundSuccessSubtle: Color.lerp(backgroundSuccessSubtle, other.backgroundSuccessSubtle, t)!,
      backgroundWarningSubtle: Color.lerp(backgroundWarningSubtle, other.backgroundWarningSubtle, t)!,
      backgroundInfoSubtle: Color.lerp(backgroundInfoSubtle, other.backgroundInfoSubtle, t)!,

      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      borderBrand: Color.lerp(borderBrand, other.borderBrand, t)!,
      borderError: Color.lerp(borderError, other.borderError, t)!,
      borderFocus: Color.lerp(borderFocus, other.borderFocus, t)!,

      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      iconDisabled: Color.lerp(iconDisabled, other.iconDisabled, t)!,
      iconBrand: Color.lerp(iconBrand, other.iconBrand, t)!,
      iconInverse: Color.lerp(iconInverse, other.iconInverse, t)!,

      tagPrimaryBackground: Color.lerp(tagPrimaryBackground, other.tagPrimaryBackground, t)!,
      tagPrimaryText: Color.lerp(tagPrimaryText, other.tagPrimaryText, t)!,
      tagGreenBackground: Color.lerp(tagGreenBackground, other.tagGreenBackground, t)!,
      tagGreenText: Color.lerp(tagGreenText, other.tagGreenText, t)!,
      tagRedBackground: Color.lerp(tagRedBackground, other.tagRedBackground, t)!,
      tagRedText: Color.lerp(tagRedText, other.tagRedText, t)!,
      tagYellowBackground: Color.lerp(tagYellowBackground, other.tagYellowBackground, t)!,
      tagYellowText: Color.lerp(tagYellowText, other.tagYellowText, t)!,
      tagGoldBackground: Color.lerp(tagGoldBackground, other.tagGoldBackground, t)!,
      tagGoldText: Color.lerp(tagGoldText, other.tagGoldText, t)!,
      tagBlueBackground: Color.lerp(tagBlueBackground, other.tagBlueBackground, t)!,
      tagBlueText: Color.lerp(tagBlueText, other.tagBlueText, t)!,
      tagGrayBackground: Color.lerp(tagGrayBackground, other.tagGrayBackground, t)!,
      tagGrayText: Color.lerp(tagGrayText, other.tagGrayText, t)!,

      isDark: t < 0.5 ? isDark : other.isDark,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MeayarColors &&
        other.isDark == isDark &&
        other.textPrimary == textPrimary &&
        other.textSecondary == textSecondary &&
        other.textTertiary == textTertiary &&
        other.textDisabled == textDisabled &&
        other.textInverse == textInverse &&
        other.textBrand == textBrand &&
        other.textError == textError &&
        other.textSuccess == textSuccess &&
        other.textWarning == textWarning &&
        other.textInfo == textInfo &&
        other.backgroundPage == backgroundPage &&
        other.backgroundSurface == backgroundSurface &&
        other.backgroundSubtle == backgroundSubtle &&
        other.backgroundMuted == backgroundMuted &&
        other.backgroundInverse == backgroundInverse &&
        other.backgroundDisabled == backgroundDisabled &&
        other.backgroundBrand == backgroundBrand &&
        other.backgroundBrandHover == backgroundBrandHover &&
        other.backgroundBrandSubtle == backgroundBrandSubtle &&
        other.backgroundError == backgroundError &&
        other.backgroundErrorSubtle == backgroundErrorSubtle &&
        other.backgroundSuccessSubtle == backgroundSuccessSubtle &&
        other.backgroundWarningSubtle == backgroundWarningSubtle &&
        other.backgroundInfoSubtle == backgroundInfoSubtle &&
        other.borderDefault == borderDefault &&
        other.borderSubtle == borderSubtle &&
        other.borderStrong == borderStrong &&
        other.borderBrand == borderBrand &&
        other.borderError == borderError &&
        other.borderFocus == borderFocus &&
        other.iconPrimary == iconPrimary &&
        other.iconSecondary == iconSecondary &&
        other.iconDisabled == iconDisabled &&
        other.iconBrand == iconBrand &&
        other.iconInverse == iconInverse &&
        other.tagPrimaryBackground == tagPrimaryBackground &&
        other.tagPrimaryText == tagPrimaryText &&
        other.tagGreenBackground == tagGreenBackground &&
        other.tagGreenText == tagGreenText &&
        other.tagRedBackground == tagRedBackground &&
        other.tagRedText == tagRedText &&
        other.tagYellowBackground == tagYellowBackground &&
        other.tagYellowText == tagYellowText &&
        other.tagGoldBackground == tagGoldBackground &&
        other.tagGoldText == tagGoldText &&
        other.tagBlueBackground == tagBlueBackground &&
        other.tagBlueText == tagBlueText &&
        other.tagGrayBackground == tagGrayBackground &&
        other.tagGrayText == tagGrayText;
  }

  @override
  int get hashCode => Object.hashAll([
        isDark,
        textPrimary,
        textSecondary,
        textTertiary,
        textDisabled,
        textInverse,
        textBrand,
        textError,
        textSuccess,
        textWarning,
        textInfo,
        backgroundPage,
        backgroundSurface,
        backgroundSubtle,
        backgroundMuted,
        backgroundInverse,
        backgroundDisabled,
        backgroundBrand,
        backgroundBrandHover,
        backgroundBrandSubtle,
        backgroundError,
        backgroundErrorSubtle,
        backgroundSuccessSubtle,
        backgroundWarningSubtle,
        backgroundInfoSubtle,
        borderDefault,
        borderSubtle,
        borderStrong,
        borderBrand,
        borderError,
        borderFocus,
        iconPrimary,
        iconSecondary,
        iconDisabled,
        iconBrand,
        iconInverse,
        tagPrimaryBackground,
        tagPrimaryText,
        tagGreenBackground,
        tagGreenText,
        tagRedBackground,
        tagRedText,
        tagYellowBackground,
        tagYellowText,
        tagGoldBackground,
        tagGoldText,
        tagBlueBackground,
        tagBlueText,
        tagGrayBackground,
        tagGrayText,
      ]);
}
