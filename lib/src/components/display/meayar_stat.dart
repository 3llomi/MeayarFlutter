import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';
import 'meayar_tag.dart';

/// Official MEAYAR Stat Card for dashboards, KPIs, and metrics.
class MeayarStatCard extends StatelessWidget {
  const MeayarStatCard({
    super.key,
    required this.title,
    required this.value,
    this.description,
    this.delta,
    this.isPositiveDelta = true,
    this.icon,
    this.onTap,
  });

  final String title;
  final String value;
  final String? description;
  final String? delta;
  final bool isPositiveDelta;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    Widget content = Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 6.0),
                Container(
                  width: 36.0,
                  height: 36.0,
                  decoration: BoxDecoration(
                    color: colors.backgroundBrandSubtle,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(icon, size: 20.0, color: colors.iconBrand),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    value,
                    style: typography.headingMd.copyWith(color: colors.textPrimary),
                    maxLines: 1,
                  ),
                ),
              ),
              if (delta != null) ...[
                const SizedBox(width: 6.0),
                MeayarTag(
                  text: delta!,
                  color: isPositiveDelta ? MeayarTagColor.green : MeayarTagColor.red,
                  hierarchy: MeayarTagHierarchy.secondary,
                  size: MeayarTagSize.small,
                ),
              ],
            ],
          ),
          if (description != null) ...[
            const SizedBox(height: 6.0),
            Text(
              description!,
              style: typography.textXs.copyWith(color: colors.textTertiary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: meayar.shapes.medium,
        child: content,
      );
    }

    return Material(
      color: colors.backgroundSurface,
      shape: RoundedRectangleBorder(
        borderRadius: meayar.shapes.medium,
        side: BorderSide(color: colors.borderSubtle, width: 1.0),
      ),
      child: content,
    );
  }
}
