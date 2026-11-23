import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

enum MeayarTagColor {
  primary,
  gray,
  green,
  red,
  yellow,
  gold,
  blue,
}

enum MeayarTagHierarchy {
  filled,
  secondary,
  outlined,
}

enum MeayarTagSize {
  large,
  medium,
  small,
}

/// Official MEAYAR Tag / Badge component for status and categorization.
class MeayarTag extends StatelessWidget {
  const MeayarTag({
    super.key,
    required this.text,
    this.color = MeayarTagColor.primary,
    this.hierarchy = MeayarTagHierarchy.secondary,
    this.size = MeayarTagSize.medium,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String text;
  final MeayarTagColor color;
  final MeayarTagHierarchy hierarchy;
  final MeayarTagSize size;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    // Resolve color pair
    Color bg;
    Color fg;

    switch (color) {
      case MeayarTagColor.primary:
        bg = colors.tagPrimaryBackground;
        fg = colors.tagPrimaryText;
        break;
      case MeayarTagColor.gray:
        bg = colors.tagGrayBackground;
        fg = colors.tagGrayText;
        break;
      case MeayarTagColor.green:
        bg = colors.tagGreenBackground;
        fg = colors.tagGreenText;
        break;
      case MeayarTagColor.red:
        bg = colors.tagRedBackground;
        fg = colors.tagRedText;
        break;
      case MeayarTagColor.yellow:
        bg = colors.tagYellowBackground;
        fg = colors.tagYellowText;
        break;
      case MeayarTagColor.gold:
        bg = colors.tagGoldBackground;
        fg = colors.tagGoldText;
        break;
      case MeayarTagColor.blue:
        bg = colors.tagBlueBackground;
        fg = colors.tagBlueText;
        break;
    }

    // Resolve hierarchy
    Color finalBg;
    Color finalFg;
    BorderSide? border;

    switch (hierarchy) {
      case MeayarTagHierarchy.filled:
        finalBg = fg;
        finalFg = colors.textInverse;
        border = null;
        break;
      case MeayarTagHierarchy.secondary:
        finalBg = bg;
        finalFg = fg;
        border = null;
        break;
      case MeayarTagHierarchy.outlined:
        finalBg = Colors.transparent;
        finalFg = fg;
        border = BorderSide(color: fg.withValues(alpha: 0.4), width: 1.0);
        break;
    }

    // Resolve size
    double height;
    EdgeInsetsGeometry padding;
    TextStyle textStyle;
    double iconSize;

    switch (size) {
      case MeayarTagSize.large:
        height = 32.0;
        padding = const EdgeInsets.symmetric(horizontal: 10.0);
        textStyle = typography.textSmMedium;
        iconSize = 16.0;
        break;
      case MeayarTagSize.medium:
        height = 26.0;
        padding = const EdgeInsets.symmetric(horizontal: 8.0);
        textStyle = typography.textXsMedium;
        iconSize = 14.0;
        break;
      case MeayarTagSize.small:
        height = 22.0;
        padding = const EdgeInsets.symmetric(horizontal: 6.0);
        textStyle = typography.text2xsMedium;
        iconSize = 12.0;
        break;
    }

    Widget content = Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: finalBg,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        border: border != null ? Border.fromBorderSide(border) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(color: finalFg, size: iconSize),
              child: leading!,
            ),
            const SizedBox(width: 4.0),
          ],
          Text(
            text,
            style: textStyle.copyWith(color: finalFg),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 4.0),
            IconTheme(
              data: IconThemeData(color: finalFg, size: iconSize),
              child: trailing!,
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        child: content,
      );
    }

    return content;
  }
}
