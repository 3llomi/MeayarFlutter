import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';
import '../buttons/meayar_button.dart';

/// Official MEAYAR Dialog helper functions and widget.
class MeayarDialog extends StatelessWidget {
  const MeayarDialog({
    super.key,
    required this.title,
    this.description,
    this.content,
    this.confirmText = 'تأكيد',
    this.cancelText,
    this.showCancel = true,
    this.onConfirm,
    this.onCancel,
    this.icon,
    this.isDestructive = false,
  });

  final String title;
  final String? description;
  final Widget? content;
  final String confirmText;
  final String? cancelText;
  final bool showCancel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Widget? icon;
  final bool isDestructive;

  /// Convenience static method to show a MEAYAR modal dialog.
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? description,
    Widget? content,
    String confirmText = 'تأكيد',
    String? cancelText,
    bool showCancel = true,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    Widget? icon,
    bool isDestructive = false,
  }) {
    return showDialog<T>(
      context: context,
      builder: (dialogContext) {
        return MeayarDialog(
          title: title,
          description: description,
          content: content,
          confirmText: confirmText,
          cancelText: cancelText,
          showCancel: showCancel,
          icon: icon,
          isDestructive: isDestructive,
          onConfirm: () {
            Navigator.pop(dialogContext);
            onConfirm?.call();
          },
          onCancel: () {
            Navigator.pop(dialogContext);
            onCancel?.call();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final effectiveConfirmText = confirmText;
    final effectiveCancelText = showCancel ? (cancelText ?? 'إلغاء') : null;

    return Dialog(
      backgroundColor: colors.backgroundSurface,
      shape: RoundedRectangleBorder(borderRadius: meayar.shapes.extraLarge),
      elevation: 4.0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420.0),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: isDestructive ? colors.backgroundErrorSubtle : colors.backgroundBrandSubtle,
                  borderRadius: meayar.shapes.medium,
                ),
                alignment: Alignment.center,
                child: icon,
              ),
              const SizedBox(height: 16.0),
            ],
            Text(
              title,
              style: typography.heading2xs.copyWith(color: colors.textPrimary),
            ),
            if (description != null) ...[
              const SizedBox(height: 8.0),
              Text(
                description!,
                style: typography.textSm.copyWith(color: colors.textSecondary),
              ),
            ],
            if (content != null) ...[
              const SizedBox(height: 16.0),
              content!,
            ],
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (effectiveCancelText != null) ...[
                  MeayarButton(
                    text: effectiveCancelText,
                    onPressed: onCancel ?? () => Navigator.pop(context),
                    variant: MeayarButtonVariant.outlined,
                    size: MeayarButtonSize.sm,
                  ),
                  const SizedBox(width: 8.0),
                ],
                MeayarButton(
                  text: effectiveConfirmText,
                  onPressed: onConfirm,
                  variant: isDestructive
                      ? MeayarButtonVariant.destructive
                      : MeayarButtonVariant.primary,
                  size: MeayarButtonSize.sm,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
