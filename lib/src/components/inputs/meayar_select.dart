import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/localization/meayar_localizations.dart';
import '../../core/theme/meayar_theme.dart';
import 'meayar_form_field_wrapper.dart';

/// Official MEAYAR Select / Dropdown menu widget.
class MeayarSelect<T> extends StatelessWidget {
  const MeayarSelect({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.itemLabel,
    this.label,
    this.isMandatory = false,
    this.placeholder,
    this.helperText,
    this.errorMessage,
    this.isError = false,
    this.enabled = true,
    this.leading,
    this.borderRadius,
  });

  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T> onItemSelected;
  final String Function(T) itemLabel;
  final String? label;
  final bool isMandatory;
  final String? placeholder;
  final String? helperText;
  final String? errorMessage;
  final bool isError;
  final bool enabled;
  final Widget? leading;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final effectivePlaceholder = placeholder ?? MeayarLocalizations.of(context).selectPlaceholder;

    final hasError = isError || (errorMessage != null && errorMessage!.isNotEmpty);
    final borderColor = !enabled
        ? colors.borderSubtle
        : hasError
            ? colors.borderError
            : colors.borderDefault;

    final effectiveRadius = borderRadius ?? meayar.shapes.small;

    return MeayarFormFieldWrapper(
      label: label,
      isMandatory: isMandatory,
      helperText: helperText,
      errorMessage: errorMessage,
      isError: isError,
      enabled: enabled,
      child: Builder(
        builder: (triggerContext) {
          return InkWell(
            onTap: enabled ? () => _showSelection(triggerContext) : null,
            borderRadius: effectiveRadius,
            child: Container(
              height: 44.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: enabled ? colors.backgroundSubtle : colors.backgroundDisabled,
                borderRadius: effectiveRadius,
                border: Border.all(color: borderColor, width: hasError ? 1.5 : 1.0),
              ),
              child: Row(
                children: [
                  if (leading != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        color: enabled ? colors.iconSecondary : colors.iconDisabled,
                        size: 20.0,
                      ),
                      child: leading!,
                    ),
                    const SizedBox(width: 8.0),
                  ],
                  Expanded(
                    child: Text(
                      selectedItem != null ? itemLabel(selectedItem as T) : effectivePlaceholder,
                      style: typography.textSm.copyWith(
                        color: selectedItem != null
                            ? (enabled ? colors.textPrimary : colors.textDisabled)
                            : colors.textDisabled,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    MeayarIcons.chevronDown,
                    color: enabled ? colors.iconSecondary : colors.iconDisabled,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSelection(BuildContext triggerContext) async {
    final renderBox = triggerContext.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final overlay = Overlay.of(triggerContext).context.findRenderObject() as RenderBox?;
    if (overlay == null) return;

    final translation = renderBox.localToGlobal(Offset.zero, ancestor: overlay);
    final size = renderBox.size;
    final rect = RelativeRect.fromRect(
      Rect.fromLTWH(translation.dx, translation.dy + size.height + 4.0, size.width, size.height),
      Offset.zero & overlay.size,
    );

    final meayar = triggerContext.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final selected = await showMenu<T>(
      context: triggerContext,
      position: rect,
      color: colors.backgroundSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: colors.borderSubtle, width: 1.0),
      ),
      elevation: 4.0,
      constraints: BoxConstraints(
        minWidth: size.width,
        maxWidth: size.width,
        maxHeight: 280.0,
      ),
      items: items.map((item) {
        final isSelected = item == selectedItem;
        return PopupMenuItem<T>(
          value: item,
          height: 44.0,
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemLabel(item),
                style: (isSelected ? typography.textSmBold : typography.textSm).copyWith(
                  color: isSelected ? colors.textBrand : colors.textPrimary,
                ),
              ),
              if (isSelected)
                Icon(MeayarIcons.check, size: 16.0, color: colors.iconBrand),
            ],
          ),
        );
      }).toList(),
    );

    if (selected != null) {
      onItemSelected(selected);
    }
  }
}
