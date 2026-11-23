import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

/// Official MEAYAR Slider styled with Syrian brand tokens.
class MeayarSlider extends StatelessWidget {
  const MeayarSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.label,
    this.enabled = true,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;

    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: colors.backgroundBrand,
        inactiveTrackColor: colors.backgroundMuted,
        thumbColor: colors.backgroundBrand,
        overlayColor: colors.backgroundBrand.withValues(alpha: 0.12),
        disabledActiveTrackColor: colors.backgroundDisabled,
        disabledInactiveTrackColor: colors.backgroundSubtle,
        disabledThumbColor: colors.textDisabled,
        trackHeight: 4.0,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9.0),
      ),
      child: Slider(
        value: value.clamp(min, max),
        min: min,
        max: max,
        divisions: divisions,
        label: label,
        onChanged: enabled ? onChanged : null,
      ),
    );
  }
}
