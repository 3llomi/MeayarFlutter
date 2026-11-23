import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

/// Official MEAYAR Divider supporting horizontal, vertical, and labeled separators.
class MeayarDivider extends StatelessWidget {
  const MeayarDivider({
    super.key,
    this.thickness = 1.0,
    this.color,
    this.label,
    this.margin = const EdgeInsets.symmetric(vertical: 8.0),
  });

  final double thickness;
  final Color? color;
  final String? label;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final resolvedColor = color ?? meayar.colors.borderSubtle;

    if (label == null) {
      return Padding(
        padding: margin,
        child: Container(
          height: thickness,
          color: resolvedColor,
        ),
      );
    }

    return Padding(
      padding: margin,
      child: Row(
        children: [
          Expanded(child: Container(height: thickness, color: resolvedColor)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              label!,
              style: meayar.typography.textXs.copyWith(color: meayar.colors.textTertiary),
            ),
          ),
          Expanded(child: Container(height: thickness, color: resolvedColor)),
        ],
      ),
    );
  }
}

/// Vertical line separator.
class MeayarVerticalDivider extends StatelessWidget {
  const MeayarVerticalDivider({
    super.key,
    this.thickness = 1.0,
    this.color,
    this.margin = const EdgeInsets.symmetric(horizontal: 8.0),
  });

  final double thickness;
  final Color? color;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final resolvedColor = color ?? meayar.colors.borderSubtle;

    return Padding(
      padding: margin,
      child: Container(
        width: thickness,
        color: resolvedColor,
      ),
    );
  }
}
