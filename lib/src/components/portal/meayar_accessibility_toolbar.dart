import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';

/// Official MEAYAR Accessibility Toolbar.
/// Critical for Syrian e-government portals to support elder citizens and users with visual needs.
class MeayarAccessibilityToolbar extends StatelessWidget {
  const MeayarAccessibilityToolbar({
    super.key,
    required this.onFontScaleDecrease,
    required this.onFontScaleReset,
    required this.onFontScaleIncrease,
    required this.isHighContrast,
    required this.onToggleHighContrast,
  });

  final VoidCallback onFontScaleDecrease;
  final VoidCallback onFontScaleReset;
  final VoidCallback onFontScaleIncrease;
  final bool isHighContrast;
  final ValueChanged<bool> onToggleHighContrast;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: colors.backgroundSubtle,
        borderRadius: meayar.shapes.medium,
        border: Border.all(color: colors.borderSubtle, width: 1.0),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentDirectional.centerStart,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(MeayarIcons.user, size: 16.0, color: colors.iconSecondary),
                const SizedBox(width: 6.0),
                Text(
                  'إمكانية الوصول:',
                  style: typography.textXsMedium.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
            const SizedBox(width: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Font Size Controls
                _ToolbarButton(
                  label: 'A-',
                  tooltip: 'تصغير الخط',
                  onTap: onFontScaleDecrease,
                  textStyle: typography.textXsMedium.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(width: 4.0),
                _ToolbarButton(
                  label: 'A',
                  tooltip: 'الخط الافتراضي',
                  onTap: onFontScaleReset,
                  textStyle: typography.textSmBold.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(width: 4.0),
                _ToolbarButton(
                  label: 'A+',
                  tooltip: 'تكبير الخط',
                  onTap: onFontScaleIncrease,
                  textStyle: typography.textMdBold.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(width: 8.0),
                Container(width: 1.0, height: 18.0, color: colors.borderDefault),
                const SizedBox(width: 8.0),
                // High Contrast Toggle (Prominent Left Button)
                Material(
                  color: isHighContrast ? colors.backgroundBrand : colors.backgroundSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(
                      color: isHighContrast ? colors.borderBrand : colors.borderSubtle,
                      width: 1.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => onToggleHighContrast(!isHighContrast),
                    borderRadius: BorderRadius.circular(6.0),
                    child: Container(
                      height: 32.0,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isHighContrast ? Icons.contrast_rounded : Icons.contrast_outlined,
                            size: 16.0,
                            color: isHighContrast ? colors.textInverse : colors.iconSecondary,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'تباين عالٍ',
                            style: typography.textXsMedium.copyWith(
                              color: isHighContrast ? colors.textInverse : colors.textPrimary,
                              fontWeight: isHighContrast ? FontWeight.w600 : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.label,
    required this.tooltip,
    required this.onTap,
    this.textStyle,
  });

  final String label;
  final String tooltip;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Tooltip(
      message: tooltip,
      child: Material(
        color: colors.backgroundSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: colors.borderSubtle, width: 1.0),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6.0),
          child: Container(
            width: 32.0,
            height: 32.0,
            alignment: Alignment.center,
            child: Text(
              label,
              style: textStyle ?? typography.textSmMedium.copyWith(color: colors.textPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
