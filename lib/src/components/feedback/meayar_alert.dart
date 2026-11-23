import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';

enum MeayarAlertStyle {
  primary,
  secondary,
  neutral,
  simple,
  success,
  warning,
  error,
}

/// Official MEAYAR Alert component supporting Syrian state styles.
class MeayarAlert extends StatelessWidget {
  const MeayarAlert({
    super.key,
    required this.title,
    required this.description,
    this.style = MeayarAlertStyle.secondary,
    this.icon,
    this.onDismiss,
    this.action,
    this.borderRadius,
  });

  final String title;
  final String description;
  final MeayarAlertStyle style;
  final Widget? icon;
  final VoidCallback? onDismiss;
  final Widget? action;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    Color bg;
    Color fgTitle;
    Color fgDesc;
    Color iconColor;
    BorderSide? border;

    switch (style) {
      case MeayarAlertStyle.primary:
        bg = colors.backgroundBrand;
        fgTitle = colors.textInverse;
        fgDesc = colors.textInverse.withValues(alpha: 0.85);
        iconColor = colors.textInverse;
        border = null;
        break;
      case MeayarAlertStyle.secondary:
        bg = colors.backgroundBrandSubtle;
        fgTitle = colors.textBrand;
        fgDesc = colors.textSecondary;
        iconColor = colors.iconBrand;
        border = BorderSide(color: colors.borderBrand.withValues(alpha: 0.3), width: 1.0);
        break;
      case MeayarAlertStyle.neutral:
        bg = colors.backgroundSubtle;
        fgTitle = colors.textPrimary;
        fgDesc = colors.textSecondary;
        iconColor = colors.iconSecondary;
        border = BorderSide(color: colors.borderSubtle, width: 1.0);
        break;
      case MeayarAlertStyle.simple:
        bg = Colors.transparent;
        fgTitle = colors.textPrimary;
        fgDesc = colors.textSecondary;
        iconColor = colors.iconBrand;
        border = BorderSide(color: colors.borderDefault, width: 1.0);
        break;
      case MeayarAlertStyle.success:
        bg = colors.backgroundSuccessSubtle;
        fgTitle = colors.textSuccess;
        fgDesc = colors.textSecondary;
        iconColor = colors.textSuccess;
        border = BorderSide(color: colors.textSuccess.withValues(alpha: 0.3), width: 1.0);
        break;
      case MeayarAlertStyle.warning:
        bg = colors.backgroundWarningSubtle;
        fgTitle = colors.textWarning;
        fgDesc = colors.textSecondary;
        iconColor = colors.textWarning;
        border = BorderSide(color: colors.textWarning.withValues(alpha: 0.3), width: 1.0);
        break;
      case MeayarAlertStyle.error:
        bg = colors.backgroundErrorSubtle;
        fgTitle = colors.textError;
        fgDesc = colors.textSecondary;
        iconColor = colors.textError;
        border = BorderSide(color: colors.borderError.withValues(alpha: 0.3), width: 1.0);
        break;
    }

    final shape = borderRadius ?? meayar.shapes.small;

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: shape,
        border: border != null ? Border.fromBorderSide(border) : null,
      ),
      padding: const EdgeInsets.all(14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon ??
              Icon(
                style == MeayarAlertStyle.warning
                    ? MeayarIcons.warning
                    : style == MeayarAlertStyle.error
                        ? MeayarIcons.error
                        : style == MeayarAlertStyle.success
                            ? MeayarIcons.checkCircle
                            : MeayarIcons.info,
                size: 20.0,
                color: iconColor,
              ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: typography.textSmBold.copyWith(color: fgTitle),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: typography.textXs.copyWith(color: fgDesc),
                ),
                if (action != null) ...[
                  const SizedBox(height: 8.0),
                  action!,
                ],
              ],
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: 8.0),
            InkWell(
              onTap: onDismiss,
              borderRadius: meayar.shapes.extraSmall,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(MeayarIcons.close, size: 16.0, color: fgDesc),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Type of floating toast notification.
enum MeayarToastType {
  success,
  error,
  warning,
  info,
}

/// Official MEAYAR Toast floating notification component.
class MeayarToast extends StatelessWidget {
  const MeayarToast({
    super.key,
    required this.title,
    this.description,
    this.type = MeayarToastType.success,
    this.onClose,
  });

  final String title;
  final String? description;
  final MeayarToastType type;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    Color bg;
    Color borderCol;
    IconData icon;
    Color textCol;

    switch (type) {
      case MeayarToastType.success:
        bg = colors.backgroundSuccessSubtle;
        borderCol = colors.textSuccess.withValues(alpha: 0.3);
        icon = MeayarIcons.checkCircle;
        textCol = colors.textSuccess;
        break;
      case MeayarToastType.error:
        bg = colors.backgroundErrorSubtle;
        borderCol = colors.borderError.withValues(alpha: 0.4);
        icon = MeayarIcons.warning;
        textCol = colors.textError;
        break;
      case MeayarToastType.warning:
        bg = colors.backgroundWarningSubtle;
        borderCol = colors.textWarning.withValues(alpha: 0.3);
        icon = MeayarIcons.warning;
        textCol = colors.textWarning;
        break;
      case MeayarToastType.info:
        bg = colors.backgroundInfoSubtle;
        borderCol = colors.textInfo.withValues(alpha: 0.3);
        icon = MeayarIcons.info;
        textCol = colors.textInfo;
        break;
    }

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: borderCol, width: 1.0),
    );

    return Material(
      color: bg,
      shape: shape,
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 20.0, color: textCol),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: typography.textSmBold.copyWith(color: textCol),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 2.0),
                    Text(
                      description!,
                      style: typography.textXs.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
            if (onClose != null) ...[
              const SizedBox(width: 8.0),
              InkWell(
                onTap: onClose,
                borderRadius: BorderRadius.circular(4.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(MeayarIcons.close, size: 16.0, color: colors.iconSecondary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
