import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

enum MeayarSpinnerSize {
  xs(16.0, 2.0),
  sm(20.0, 2.5),
  md(28.0, 3.0),
  lg(36.0, 3.5),
  xl(48.0, 4.0);

  const MeayarSpinnerSize(this.diameter, this.strokeWidth);
  final double diameter;
  final double strokeWidth;
}

/// Official MEAYAR Linear Progress Bar.
class MeayarProgressBar extends StatelessWidget {
  const MeayarProgressBar({
    super.key,
    this.value, // null for indeterminate
    this.height = 6.0,
    this.color,
    this.backgroundColor,
    this.borderRadius,
  });

  final double? value;
  final double height;
  final Color? color;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final shape = borderRadius ?? meayar.shapes.pill;

    return ClipRRect(
      borderRadius: shape,
      child: SizedBox(
        height: height,
        child: LinearProgressIndicator(
          value: value?.clamp(0.0, 1.0),
          backgroundColor: backgroundColor ?? colors.backgroundMuted,
          valueColor: AlwaysStoppedAnimation<Color>(color ?? colors.backgroundBrand),
        ),
      ),
    );
  }
}

/// Official MEAYAR Circular Spinner.
class MeayarSpinner extends StatelessWidget {
  const MeayarSpinner({
    super.key,
    this.size = MeayarSpinnerSize.md,
    this.label,
    this.isInverse = false,
    this.color,
  });

  final MeayarSpinnerSize size;
  final String? label;
  final bool isInverse;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final effectiveColor = color ?? (isInverse ? colors.textInverse : colors.backgroundBrand);

    final spinner = SizedBox(
      width: size.diameter,
      height: size.diameter,
      child: CircularProgressIndicator(
        strokeWidth: size.strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
      ),
    );

    if (label == null) return spinner;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        spinner,
        const SizedBox(width: 10.0),
        Flexible(
          child: Text(
            label!,
            style: typography.textSmMedium.copyWith(
              color: isInverse ? colors.textInverse : colors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

/// Official MEAYAR Skeleton Loader with pulsing shimmer effect.
class MeayarSkeleton extends StatefulWidget {
  const MeayarSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  State<MeayarSkeleton> createState() => _MeayarSkeletonState();
}

class _MeayarSkeletonState extends State<MeayarSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final shape = widget.borderRadius ?? const BorderRadius.all(Radius.circular(8.0));

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: colors.backgroundDisabled.withValues(alpha: _animation.value),
            borderRadius: shape,
          ),
        );
      },
    );
  }
}

/// Official MEAYAR Badge dot or counter.
class MeayarBadge extends StatelessWidget {
  const MeayarBadge({
    super.key,
    this.count,
    this.color,
    this.containerColor,
    this.textColor,
    this.child,
  });

  final int? count;
  final Color? color;
  final Color? containerColor;
  final Color? textColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final badgeColor = containerColor ?? color ?? colors.backgroundError;
    final textCol = textColor ?? colors.textInverse;

    final badgeWidget = Container(
      padding: count != null
          ? const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0)
          : const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: meayar.shapes.pill,
      ),
      child: count != null
          ? Text(
              count! > 99 ? '99+' : '$count',
              style: typography.text2xsMedium.copyWith(color: textCol),
            )
          : const SizedBox.shrink(),
    );

    if (child == null) return badgeWidget;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        PositionedDirectional(
          top: -4.0,
          end: -4.0,
          child: badgeWidget,
        ),
      ],
    );
  }
}
