import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
import '../buttons/meayar_button.dart';

/// Official MEAYAR Cookie Consent & Privacy Notice Banner.
class MeayarCookieConsent extends StatelessWidget {
  const MeayarCookieConsent({
    super.key,
    required this.onAcceptAll,
    this.title = 'إشعار الخصوصية وملفات تعريف الارتباط',
    this.description = 'تستخدم بوابة معيار للخدمات الحكومية ملفات تعريف الارتباط الأساسية لضمان أمان الجلسات وتقديم الخدمات الرقمية الموثوقة وفق معايير الخصوصية الوطنية.',
    this.acceptText = 'قبول الكل',
    this.onCustomize,
    this.customizeText = 'تخصيص الإعدادات',
    this.onDecline,
    this.declineText = 'الضرورية فقط',
  });

  final VoidCallback onAcceptAll;
  final String title;
  final String description;
  final String acceptText;
  final VoidCallback? onCustomize;
  final String? customizeText;
  final VoidCallback? onDecline;
  final String? declineText;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final effectiveTitle = title;
    final effectiveDescription = description;
    final effectiveAccept = acceptText;
    final effectiveCustomize = customizeText;
    final effectiveDecline = declineText;

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: colors.backgroundSurface,
        borderRadius: meayar.shapes.large,
        border: Border.all(color: colors.borderSubtle, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: colors.backgroundBrandSubtle,
                  borderRadius: meayar.shapes.small,
                ),
                child: Icon(MeayarIcons.shield, color: colors.iconBrand, size: 20.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  effectiveTitle,
                  style: typography.textSmBold.copyWith(color: colors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            effectiveDescription,
            style: typography.textXs.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              MeayarButton(
                text: effectiveAccept,
                onPressed: onAcceptAll,
                variant: MeayarButtonVariant.primary,
                size: MeayarButtonSize.sm,
              ),
              if (onDecline != null)
                MeayarButton(
                  text: effectiveDecline,
                  onPressed: onDecline,
                  variant: MeayarButtonVariant.outlined,
                  size: MeayarButtonSize.sm,
                ),
              if (onCustomize != null)
                MeayarButton(
                  text: effectiveCustomize,
                  onPressed: onCustomize,
                  variant: MeayarButtonVariant.ghost,
                  size: MeayarButtonSize.sm,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
