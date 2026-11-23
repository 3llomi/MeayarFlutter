import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';
import 'meayar_button.dart';

/// Item definition for [MeayarSegmentedButton] and [MeayarButtonGroup].
class MeayarButtonGroupItem {
  const MeayarButtonGroupItem({
    required this.title,
    this.leading,
    this.trailing,
    this.enabled = true,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final bool enabled;
}

/// Official MEAYAR Segmented Button (Connected Button Group).
/// Supports single selection toggle with proper RTL-aware outer corners and dividers.
class MeayarSegmentedButton extends StatelessWidget {
  const MeayarSegmentedButton({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.selectedIndex,
    this.size = MeayarButtonSize.md,
    this.variant = MeayarButtonVariant.outlined,
    this.borderRadius,
    this.fullWidth = true,
  });

  final List<MeayarButtonGroupItem> items;
  final ValueChanged<int> onItemSelected;
  final int? selectedIndex;
  final MeayarButtonSize size;
  final MeayarButtonVariant variant;
  final BorderRadius? borderRadius;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final meayar = context.meayar;
    final colors = meayar.colors;
    final specs = MeayarButtonSpecs.get(size);
    final outerRadius = borderRadius ?? specs.borderRadius;

    return _BaseButtonGroup(
      items: items,
      specs: specs,
      size: size,
      fullWidth: fullWidth,
      outerRadius: outerRadius,
      containerBg: colors.backgroundSubtle,
      borderColor: colors.borderDefault,
      dividerColor: colors.borderDefault,
      getItemColors: (index) {
        final isSelected = selectedIndex == index;
        return (
          bg: isSelected ? colors.backgroundBrand : Colors.transparent,
          fg: isSelected ? colors.textInverse : colors.textPrimary,
        );
      },
      onItemSelected: onItemSelected,
    );
  }
}

/// Official MEAYAR Button Group for multiple independent actions.
class MeayarButtonGroup extends StatelessWidget {
  const MeayarButtonGroup({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.size = MeayarButtonSize.md,
    this.variant = MeayarButtonVariant.secondary,
    this.borderRadius,
    this.fullWidth = true,
  });

  final List<MeayarButtonGroupItem> items;
  final ValueChanged<int> onItemSelected;
  final MeayarButtonSize size;
  final MeayarButtonVariant variant;
  final BorderRadius? borderRadius;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final meayar = context.meayar;
    final colors = meayar.colors;
    final specs = MeayarButtonSpecs.get(size);
    final outerRadius = borderRadius ?? specs.borderRadius;

    final bg = variant == MeayarButtonVariant.primary
        ? colors.backgroundBrand
        : variant == MeayarButtonVariant.secondary
            ? colors.backgroundBrandSubtle
            : colors.backgroundSurface;

    final fg = variant == MeayarButtonVariant.primary
        ? colors.textInverse
        : colors.textBrand;

    final border = colors.borderSubtle;

    return _BaseButtonGroup(
      items: items,
      specs: specs,
      size: size,
      fullWidth: fullWidth,
      outerRadius: outerRadius,
      containerBg: bg,
      borderColor: border,
      dividerColor: border,
      getItemColors: (index) => (bg: Colors.transparent, fg: fg),
      onItemSelected: onItemSelected,
    );
  }
}

class _BaseButtonGroup extends StatelessWidget {
  const _BaseButtonGroup({
    required this.items,
    required this.specs,
    required this.size,
    required this.fullWidth,
    required this.outerRadius,
    required this.containerBg,
    required this.borderColor,
    required this.dividerColor,
    required this.getItemColors,
    required this.onItemSelected,
  });

  final List<MeayarButtonGroupItem> items;
  final MeayarButtonSpecs specs;
  final MeayarButtonSize size;
  final bool fullWidth;
  final BorderRadius outerRadius;
  final Color containerBg;
  final Color borderColor;
  final Color dividerColor;
  final ({Color bg, Color fg}) Function(int index) getItemColors;
  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final typography = context.meayarTypography;

    TextStyle textStyle;
    switch (size) {
      case MeayarButtonSize.xl:
        textStyle = typography.textLgMedium;
        break;
      case MeayarButtonSize.lg:
      case MeayarButtonSize.md:
      case MeayarButtonSize.sm:
        textStyle = typography.textSmMedium;
        break;
      case MeayarButtonSize.xs:
        textStyle = typography.textXsMedium;
        break;
    }

    final children = <Widget>[];
    for (int index = 0; index < items.length; index++) {
      final item = items[index];
      final isFirst = index == 0;
      final itemColors = getItemColors(index);

      if (!isFirst) {
        children.add(
          Container(
            width: 1.0,
            height: specs.height,
            color: dividerColor,
          ),
        );
      }

      final titleWidget = fullWidth
          ? Flexible(
              child: Text(
                item.title,
                style: textStyle.copyWith(color: itemColors.fg),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          : Text(
              item.title,
              style: textStyle.copyWith(color: itemColors.fg),
              maxLines: 1,
            );

      final buttonWidget = Material(
        color: itemColors.bg,
        child: InkWell(
          onTap: item.enabled ? () => onItemSelected(index) : null,
          child: Container(
            height: specs.height,
            padding: EdgeInsets.symmetric(horizontal: specs.horizontalPadding),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (item.leading != null) ...[
                  IconTheme(
                    data: IconThemeData(color: itemColors.fg, size: specs.iconSize),
                    child: item.leading!,
                  ),
                  SizedBox(width: specs.iconGap),
                ],
                titleWidget,
                if (item.trailing != null) ...[
                  SizedBox(width: specs.iconGap),
                  IconTheme(
                    data: IconThemeData(color: itemColors.fg, size: specs.iconSize),
                    child: item.trailing!,
                  ),
                ],
              ],
            ),
          ),
        ),
      );

      if (fullWidth) {
        children.add(Expanded(child: buttonWidget));
      } else {
        children.add(buttonWidget);
      }
    }

    return Container(
      width: fullWidth ? double.infinity : null,
      height: specs.height,
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: outerRadius,
        border: Border.all(color: borderColor, width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: children,
      ),
    );
  }
}
