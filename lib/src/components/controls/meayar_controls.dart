import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';

/// Official MEAYAR Checkbox with label and description support.
class MeayarCheckbox extends StatelessWidget {
  const MeayarCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.label,
    this.description,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final String? label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final isInteractive = enabled && onChanged != null;

    final box = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        color: !enabled
            ? colors.backgroundDisabled
            : value
                ? colors.backgroundBrand
                : colors.backgroundSurface,
        borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        border: Border.all(
          color: !enabled
              ? colors.borderSubtle
              : value
                  ? colors.borderBrand
                  : colors.borderStrong,
          width: 1.5,
        ),
      ),
      child: value
          ? Icon(
              MeayarIcons.check,
              size: 14.0,
              color: !enabled ? colors.textDisabled : colors.textInverse,
            )
          : null,
    );

    if (label == null && description == null) {
      return GestureDetector(
        onTap: isInteractive ? () => onChanged!(!value) : null,
        child: box,
      );
    }

    return InkWell(
      onTap: isInteractive ? () => onChanged!(!value) : null,
      borderRadius: meayar.shapes.small,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: box,
            ),
            const SizedBox(width: 10.0),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: typography.textSmMedium.copyWith(
                        color: enabled ? colors.textPrimary : colors.textDisabled,
                      ),
                    ),
                  if (description != null) ...[
                    const SizedBox(height: 2.0),
                    Text(
                      description!,
                      style: typography.textXs.copyWith(
                        color: enabled ? colors.textTertiary : colors.textDisabled,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Official MEAYAR Radio Button with label and description support.
class MeayarRadio<T> extends StatelessWidget {
  const MeayarRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.enabled = true,
    this.label,
    this.description,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;
  final bool enabled;
  final String? label;
  final String? description;

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final isInteractive = enabled && onChanged != null;

    final circle = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.backgroundSurface,
        border: Border.all(
          color: !enabled
              ? colors.borderSubtle
              : isSelected
                  ? colors.borderBrand
                  : colors.borderStrong,
          width: 1.5,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: !enabled ? colors.textDisabled : colors.backgroundBrand,
              ),
            )
          : null,
    );

    if (label == null && description == null) {
      return GestureDetector(
        onTap: isInteractive ? () => onChanged!(value) : null,
        child: circle,
      );
    }

    return InkWell(
      onTap: isInteractive ? () => onChanged!(value) : null,
      borderRadius: meayar.shapes.small,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: circle,
            ),
            const SizedBox(width: 10.0),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: typography.textSmMedium.copyWith(
                        color: enabled ? colors.textPrimary : colors.textDisabled,
                      ),
                    ),
                  if (description != null) ...[
                    const SizedBox(height: 2.0),
                    Text(
                      description!,
                      style: typography.textXs.copyWith(
                        color: enabled ? colors.textTertiary : colors.textDisabled,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Official MEAYAR Toggle Switch with Syrian Pine Green brand styling.
class MeayarSwitch extends StatelessWidget {
  const MeayarSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
    this.label,
    this.description,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final bool enabled;
  final String? label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final isInteractive = enabled && onChanged != null;

    final track = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 44.0,
      height: 24.0,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        color: !enabled
            ? colors.backgroundDisabled
            : value
                ? colors.backgroundBrand
                : colors.backgroundMuted,
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: value ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
        child: Container(
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 3.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );

    if (label == null && description == null) {
      return GestureDetector(
        onTap: isInteractive ? () => onChanged!(!value) : null,
        child: track,
      );
    }

    return InkWell(
      onTap: isInteractive ? () => onChanged!(!value) : null,
      borderRadius: meayar.shapes.small,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null)
                    Text(
                      label!,
                      style: typography.textSmMedium.copyWith(
                        color: enabled ? colors.textPrimary : colors.textDisabled,
                      ),
                    ),
                  if (description != null) ...[
                    const SizedBox(height: 2.0),
                    Text(
                      description!,
                      style: typography.textXs.copyWith(
                        color: enabled ? colors.textTertiary : colors.textDisabled,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            track,
          ],
        ),
      ),
    );
  }
}
