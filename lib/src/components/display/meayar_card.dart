import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';
import '../buttons/meayar_button.dart';
import 'meayar_tag.dart';

/// Metadata item for Syrian public service cards.
class MeayarServiceMeta {
  const MeayarServiceMeta({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

/// Standard MEAYAR Card container for content modules.
class MeayarCard extends StatelessWidget {
  const MeayarCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.elevation = 0.0,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final shape = RoundedRectangleBorder(
      borderRadius: borderRadius ?? meayar.shapes.large,
      side: BorderSide(color: borderColor ?? colors.borderSubtle, width: 1.0),
    );

    return Material(
      color: backgroundColor ?? colors.backgroundSurface,
      shape: shape,
      elevation: elevation,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

/// Official MEAYAR Service Card (بطاقة الخدمة الحكومية).
/// Tailored for Syrian government and public service portals.
class MeayarServiceCard extends StatelessWidget {
  const MeayarServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.onStartService,
    this.onViewDetails,
    this.startServiceText = 'ابدأ الخدمة',
    this.viewDetailsText = 'تفاصيل الخدمة',
    this.tagText,
    this.tagColor = MeayarTagColor.primary,
    this.metaList = const [],
    this.icon,
  });

  final String title;
  final String description;
  final VoidCallback onStartService;
  final VoidCallback? onViewDetails;
  final String startServiceText;
  final String viewDetailsText;
  final String? tagText;
  final MeayarTagColor tagColor;
  final List<MeayarServiceMeta> metaList;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final effectiveStart = startServiceText;
    final effectiveDetails = viewDetailsText;

    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundSurface,
        borderRadius: meayar.shapes.large,
        border: Border.all(color: colors.borderSubtle, width: 1.0),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Tag
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null)
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: colors.backgroundBrandSubtle,
                    borderRadius: meayar.shapes.small,
                  ),
                  child: Icon(icon, color: colors.iconBrand, size: 24.0),
                )
              else
                const SizedBox.shrink(),
              if (tagText != null)
                MeayarTag(
                  text: tagText!,
                  color: tagColor,
                  hierarchy: MeayarTagHierarchy.secondary,
                ),
            ],
          ),
          const SizedBox(height: 14.0),

          // Title & Description
          Text(
            title,
            style: typography.heading2xs.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 6.0),
          Text(
            description,
            style: typography.textSm.copyWith(color: colors.textSecondary),
          ),

          // Metadata: Fee, Duration, Channel in subtle container
          if (metaList.isNotEmpty) ...[
            const SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: colors.backgroundSubtle,
                borderRadius: meayar.shapes.small,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: metaList.map((meta) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(meta.icon, size: 16.0, color: colors.iconSecondary),
                      const SizedBox(width: 6.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meta.label,
                            style: typography.text2xs.copyWith(color: colors.textTertiary),
                          ),
                          Text(
                            meta.value,
                            style: typography.textXsMedium.copyWith(color: colors.textPrimary),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],

          const SizedBox(height: 20.0),

          // Action Buttons: Primary Start + Secondary Details
          Row(
            children: [
              Expanded(
                child: MeayarButton(
                  text: effectiveStart,
                  onPressed: onStartService,
                  variant: MeayarButtonVariant.primary,
                  size: MeayarButtonSize.md,
                ),
              ),
              if (onViewDetails != null) ...[
                const SizedBox(width: 10.0),
                MeayarButton(
                  text: effectiveDetails,
                  onPressed: onViewDetails,
                  variant: MeayarButtonVariant.ghost,
                  size: MeayarButtonSize.md,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
