import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_colors.dart';
import '../../core/theme/meayar_theme.dart';

enum MeayarSnackbarStyle {
  inverse,
  brand,
  success,
  error,
  warning,
  info,
}

/// Official MEAYAR Floating SnackBar / Toast notification.
class MeayarSnackbar {
  const MeayarSnackbar._();

  static void show(
    BuildContext context, {
    required String message,
    MeayarSnackbarStyle style = MeayarSnackbarStyle.inverse,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    Widget? icon,
  }) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final resolved = _MeayarSnackbarResolvedStyle.resolve(style, colors);
    final bg = resolved.bg;
    final fg = resolved.fg;
    final actionColor = resolved.actionColor;

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: bg,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: meayar.shapes.medium),
        content: Row(
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 12.0),
            ] else if (resolved.defaultIcon != null) ...[
              Icon(
                resolved.defaultIcon,
                size: 20.0,
                color: fg,
              ),
              const SizedBox(width: 12.0),
            ],
            Expanded(
              child: Text(
                message,
                style: typography.textSmMedium.copyWith(color: fg),
              ),
            ),
          ],
        ),
        action: actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: actionColor,
                onPressed: onAction ?? () {},
              )
            : null,
      ),
    );
  }
}

/// Standalone MEAYAR Snackbar widget for inline previews and custom snackbar hosts.
class MeayarSnackbarWidget extends StatelessWidget {
  const MeayarSnackbarWidget({
    super.key,
    required this.message,
    this.actionLabel,
    this.onActionClick,
    this.onDismissClick,
    this.style = MeayarSnackbarStyle.inverse,
    this.icon,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onActionClick;
  final VoidCallback? onDismissClick;
  final MeayarSnackbarStyle style;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final resolved = _MeayarSnackbarResolvedStyle.resolve(style, colors);
    final bg = resolved.bg;
    final fg = resolved.fg;
    final actionColor = resolved.actionColor;

    return Material(
      color: bg,
      borderRadius: meayar.shapes.medium,
      elevation: 4.0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 12.0),
            ] else if (resolved.defaultIcon != null) ...[
              Icon(
                resolved.defaultIcon,
                size: 20.0,
                color: fg,
              ),
              const SizedBox(width: 12.0),
            ],
            Expanded(
              child: Text(
                message,
                style: typography.textSmMedium.copyWith(color: fg),
              ),
            ),
            if (actionLabel != null) ...[
              const SizedBox(width: 12.0),
              GestureDetector(
                onTap: onActionClick,
                child: Text(
                  actionLabel!,
                  style: typography.textSmBold.copyWith(color: actionColor),
                ),
              ),
            ],
            if (onDismissClick != null) ...[
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: onDismissClick,
                child: Icon(MeayarIcons.close, size: 18.0, color: fg),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MeayarSnackbarResolvedStyle {
  const _MeayarSnackbarResolvedStyle({
    required this.bg,
    required this.fg,
    required this.actionColor,
    this.defaultIcon,
  });

  final Color bg;
  final Color fg;
  final Color actionColor;
  final IconData? defaultIcon;

  static _MeayarSnackbarResolvedStyle resolve(
    MeayarSnackbarStyle style,
    MeayarColors colors,
  ) {
    switch (style) {
      case MeayarSnackbarStyle.inverse:
        return const _MeayarSnackbarResolvedStyle(
          bg: MeayarPrimitives.neutral900,
          fg: Colors.white,
          actionColor: MeayarPrimitives.syrianGold400,
        );
      case MeayarSnackbarStyle.brand:
        return _MeayarSnackbarResolvedStyle(
          bg: colors.backgroundBrand,
          fg: colors.textInverse,
          actionColor: MeayarPrimitives.syrianGold400,
        );
      case MeayarSnackbarStyle.success:
        return _MeayarSnackbarResolvedStyle(
          bg: colors.backgroundSuccessSubtle,
          fg: colors.textSuccess,
          actionColor: colors.textSuccess,
          defaultIcon: MeayarIcons.checkCircle,
        );
      case MeayarSnackbarStyle.error:
        return _MeayarSnackbarResolvedStyle(
          bg: colors.backgroundErrorSubtle,
          fg: colors.textError,
          actionColor: colors.textError,
          defaultIcon: MeayarIcons.error,
        );
      case MeayarSnackbarStyle.warning:
        return _MeayarSnackbarResolvedStyle(
          bg: colors.backgroundWarningSubtle,
          fg: colors.textWarning,
          actionColor: colors.textWarning,
          defaultIcon: MeayarIcons.warning,
        );
      case MeayarSnackbarStyle.info:
        return _MeayarSnackbarResolvedStyle(
          bg: colors.backgroundInfoSubtle,
          fg: colors.textInfo,
          actionColor: colors.textInfo,
          defaultIcon: MeayarIcons.info,
        );
    }
  }
}
