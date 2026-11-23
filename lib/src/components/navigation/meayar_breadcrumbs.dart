import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
export 'meayar_pagination.dart';

/// Official MEAYAR Breadcrumb navigation trail.
class MeayarBreadcrumbs extends StatelessWidget {
  const MeayarBreadcrumbs({
    super.key,
    required this.items,
    required this.onItemClick,
  });

  final List<String> items;
  final ValueChanged<int> onItemClick;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final separatorIcon =  MeayarIcons.chevronRight;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) {
          final isLast = index == items.length - 1;

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: isLast ? null : () => onItemClick(index),
                borderRadius: meayar.shapes.extraSmall,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  child: Text(
                    items[index],
                    style: typography.textSmMedium.copyWith(
                      color: isLast ? colors.textPrimary : colors.textTertiary,
                    ),
                  ),
                ),
              ),
              if (!isLast) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(separatorIcon, size: 14.0, color: colors.iconSecondary),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
