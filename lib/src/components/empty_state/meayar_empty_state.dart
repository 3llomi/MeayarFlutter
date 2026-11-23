import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
import '../buttons/meayar_button.dart';

enum MeayarEmptyStateType {
  noData,
  noResults,
  error,
}

/// Official MEAYAR Empty State display widget.
class MeayarEmptyState extends StatelessWidget {
  const MeayarEmptyState({
    super.key,
    required this.title,
    required this.description,
    this.type = MeayarEmptyStateType.noData,
    this.icon,
    this.actionText,
    this.onActionClick,
    this.secondaryActionText,
    this.onSecondaryActionClick,
  });

  final String title;
  final String description;
  final MeayarEmptyStateType type;
  final Widget? icon;
  final String? actionText;
  final VoidCallback? onActionClick;
  final String? secondaryActionText;
  final VoidCallback? onSecondaryActionClick;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final defaultIcon = type == MeayarEmptyStateType.error
        ? MeayarIcons.warning
        : type == MeayarEmptyStateType.noResults
            ? MeayarIcons.search
            : MeayarIcons.document;

    final iconBg = type == MeayarEmptyStateType.error
        ? colors.backgroundErrorSubtle
        : colors.backgroundBrandSubtle;

    final iconColor = type == MeayarEmptyStateType.error
        ? colors.textError
        : colors.iconBrand;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 64.0,
              height: 64.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg,
              ),
              alignment: Alignment.center,
              child: icon ?? Icon(defaultIcon, size: 32.0, color: iconColor),
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: typography.heading2xs.copyWith(color: colors.textPrimary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: typography.textSm.copyWith(color: colors.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (actionText != null || secondaryActionText != null) ...[
              const SizedBox(height: 20.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (actionText != null)
                    MeayarButton(
                      text: actionText,
                      onPressed: onActionClick,
                      variant: MeayarButtonVariant.primary,
                      size: MeayarButtonSize.sm,
                    ),
                  if (secondaryActionText != null) ...[
                    const SizedBox(width: 8.0),
                    MeayarButton(
                      text: secondaryActionText,
                      onPressed: onSecondaryActionClick,
                      variant: MeayarButtonVariant.outlined,
                      size: MeayarButtonSize.sm,
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
