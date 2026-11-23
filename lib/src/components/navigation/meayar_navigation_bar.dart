import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

/// Item descriptor for [MeayarNavigationBar].
class MeayarNavigationItem {
  const MeayarNavigationItem({
    required this.title,
    required this.icon,
    this.selectedIcon,
    this.badgeCount,
  });

  final String title;
  final IconData icon;
  final IconData? selectedIcon;
  final int? badgeCount;
}

/// Official MEAYAR Bottom Navigation Bar with Syrian pine green active indicators and badges.
class MeayarNavigationBar extends StatelessWidget {
  const MeayarNavigationBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  final List<MeayarNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundSurface,
        border: Border(top: BorderSide(color: colors.borderSubtle, width: 1.0)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = selectedIndex == index;
                final itemColor = isSelected ? colors.textBrand : colors.textTertiary;

                return Expanded(
                  child: InkWell(
                    onTap: () => onItemSelected(index),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: isSelected ? colors.backgroundBrandSubtle : Colors.transparent,
                                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                ),
                                child: Icon(
                                  isSelected ? (item.selectedIcon ?? item.icon) : item.icon,
                                  size: 22.0,
                                  color: itemColor,
                                ),
                              ),
                              if (item.badgeCount != null && item.badgeCount! > 0)
                                PositionedDirectional(
                                  top: -2.0,
                                  end: -2.0,
                                  child: Container(
                                    width: 16.0,
                                    height: 16.0,
                                    decoration: BoxDecoration(
                                      color: colors.backgroundError,
                                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      item.badgeCount! > 99 ? '99+' : '${item.badgeCount}',
                                      style: typography.text2xs.copyWith(color: colors.textInverse),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            item.title,
                            style: (isSelected ? typography.textXsMedium : typography.textXs)
                                .copyWith(color: itemColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
