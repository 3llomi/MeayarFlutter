import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

/// Button visual style variants for [MeayarButton].
enum MeayarButtonVariant {
  primary,
  secondary,
  outlined,
  ghost,
  destructive,
}

/// Button size scales for [MeayarButton].
enum MeayarButtonSize {
  xl,
  lg,
  md,
  sm,
  xs,
}

class MeayarButtonSpecs {
  const MeayarButtonSpecs({
    required this.height,
    required this.horizontalPadding,
    required this.iconGap,
    required this.iconSize,
    required this.borderRadius,
  });

  final double height;
  final double horizontalPadding;
  final double iconGap;
  final double iconSize;
  final BorderRadius borderRadius;

  static MeayarButtonSpecs get(MeayarButtonSize size) {
    switch (size) {
      case MeayarButtonSize.xl:
        return const MeayarButtonSpecs(
          height: 60.0,
          horizontalPadding: 24.0,
          iconGap: 12.0,
          iconSize: 24.0,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        );
      case MeayarButtonSize.lg:
        return const MeayarButtonSpecs(
          height: 48.0,
          horizontalPadding: 20.0,
          iconGap: 10.0,
          iconSize: 20.0,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        );
      case MeayarButtonSize.md:
        return const MeayarButtonSpecs(
          height: 44.0,
          horizontalPadding: 16.0,
          iconGap: 8.0,
          iconSize: 20.0,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        );
      case MeayarButtonSize.sm:
        return const MeayarButtonSpecs(
          height: 32.0,
          horizontalPadding: 12.0,
          iconGap: 8.0,
          iconSize: 16.0,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        );
      case MeayarButtonSize.xs:
        return const MeayarButtonSpecs(
          height: 26.0,
          horizontalPadding: 10.0,
          iconGap: 6.0,
          iconSize: 14.0,
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        );
    }
  }
}

/// Official MEAYAR Button conforming to the Syrian Digital Design System.
/// Fully customizable with leading/trailing widgets, loading states, and RTL awareness.
class MeayarButton extends StatelessWidget {
  const MeayarButton({
    super.key,
    required this.onPressed,
    this.text,
    this.child,
    this.variant = MeayarButtonVariant.primary,
    this.size = MeayarButtonSize.md,
    this.loading = false,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.fullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
  }) : assert(text != null || child != null, 'Either text or child must be provided.');

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final MeayarButtonVariant variant;
  final MeayarButtonSize size;
  final bool loading;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final bool fullWidth;

  // Overrides
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final specs = MeayarButtonSpecs.get(size);

    final isInteractive = enabled && !loading && onPressed != null;

    // Resolve Colors
    Color bg;
    Color fg;
    BorderSide? border;

    if (!isInteractive && !loading) {
      bg = variant == MeayarButtonVariant.ghost ? Colors.transparent : colors.backgroundDisabled;
      fg = colors.textDisabled;
      border = variant == MeayarButtonVariant.outlined
          ? BorderSide(color: colors.borderSubtle, width: 1.0)
          : null;
    } else {
      switch (variant) {
        case MeayarButtonVariant.primary:
          bg = backgroundColor ?? colors.backgroundBrand;
          fg = foregroundColor ?? colors.textInverse;
          border = null;
          break;
        case MeayarButtonVariant.secondary:
          bg = backgroundColor ?? colors.backgroundBrandSubtle;
          fg = foregroundColor ?? colors.textBrand;
          border = null;
          break;
        case MeayarButtonVariant.outlined:
          bg = backgroundColor ?? Colors.transparent;
          fg = foregroundColor ?? colors.textBrand;
          border = BorderSide(color: borderColor ?? colors.borderBrand, width: 1.0);
          break;
        case MeayarButtonVariant.ghost:
          bg = backgroundColor ?? Colors.transparent;
          fg = foregroundColor ?? colors.textBrand;
          border = null;
          break;
        case MeayarButtonVariant.destructive:
          bg = backgroundColor ?? colors.backgroundError;
          fg = foregroundColor ?? colors.textInverse;
          border = null;
          break;
      }
    }

    // Resolve Typography
    TextStyle textStyle;
    switch (size) {
      case MeayarButtonSize.xl:
        textStyle = typography.textLgMedium;
        break;
      case MeayarButtonSize.lg:
      case MeayarButtonSize.md:
        textStyle = typography.textSmMedium;
        break;
      case MeayarButtonSize.sm:
        textStyle = typography.textSmMedium;
        break;
      case MeayarButtonSize.xs:
        textStyle = typography.textXsMedium;
        break;
    }

    final resolvedShape = RoundedRectangleBorder(
      borderRadius: borderRadius ?? specs.borderRadius,
      side: border ?? BorderSide.none,
    );

    final Widget content;
    if (loading) {
      content = Center(
        child: SizedBox(
          width: specs.iconSize,
          height: specs.iconSize,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(fg),
          ),
        ),
      );
    } else {
      content = Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(color: fg, size: specs.iconSize),
              child: leading!,
            ),
            SizedBox(width: specs.iconGap),
          ],
          if (child != null)
            IconTheme(
              data: IconThemeData(color: fg, size: specs.iconSize),
              child: DefaultTextStyle(style: textStyle.copyWith(color: fg), child: child!),
            )
          else if (text != null)
            Text(
              text!,
              style: textStyle.copyWith(color: fg),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          if (trailing != null) ...[
            SizedBox(width: specs.iconGap),
            IconTheme(
              data: IconThemeData(color: fg, size: specs.iconSize),
              child: trailing!,
            ),
          ],
        ],
      );
    }

    Widget button = Material(
      color: bg,
      shape: resolvedShape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isInteractive ? onPressed : null,
        customBorder: resolvedShape,
        splashColor: fg.withValues(alpha: 0.12),
        highlightColor: fg.withValues(alpha: 0.08),
        child: Container(
          height: specs.height,
          padding: padding ?? EdgeInsets.symmetric(horizontal: specs.horizontalPadding),
          child: content,
        ),
      ),
    );

    if (fullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return Semantics(
      button: true,
      enabled: isInteractive,
      child: button,
    );
  }
}
