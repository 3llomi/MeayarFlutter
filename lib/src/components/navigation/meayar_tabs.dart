import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

enum MeayarTabStyle {
  line,
  pill,
}

/// Official MEAYAR Tabs component with line and pill styles.
class MeayarTabs extends StatelessWidget {
  const MeayarTabs({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.style = MeayarTabStyle.line,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final MeayarTabStyle style;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    if (style == MeayarTabStyle.pill) {
      return Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: colors.backgroundSubtle,
          borderRadius: meayar.shapes.medium,
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = selectedIndex == index;
            // Matched-RGB alpha interpolation avoids interpolating through dark grey
            final targetBg = isSelected
                ? colors.backgroundSurface
                : colors.backgroundSurface.withValues(alpha: 0.0);
            final targetText = isSelected ? colors.textBrand : colors.textTertiary;

            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                decoration: BoxDecoration(
                  color: targetBg,
                  borderRadius: meayar.shapes.small,
                ),
                child: InkWell(
                  onTap: () => onTabSelected(index),
                  borderRadius: meayar.shapes.small,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 150),
                        style: typography.textSmMedium.copyWith(color: targetText),
                        child: Text(tabs[index]),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }

    // Line Style (Underline)
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.borderSubtle, width: 1.0)),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          final targetText = isSelected ? colors.textBrand : colors.textTertiary;
          final targetLine = isSelected
              ? colors.borderBrand
              : colors.borderBrand.withValues(alpha: 0.0);

          return Expanded(
            child: InkWell(
              onTap: () => onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: targetLine,
                      width: 2.0,
                    ),
                  ),
                ),
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 150),
                    style: typography.textSmMedium.copyWith(color: targetText),
                    child: Text(tabs[index]),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
