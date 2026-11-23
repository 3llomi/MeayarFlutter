import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_colors.dart';
import '../../core/theme/meayar_theme.dart';

/// Official MEAYAR Star Rating component.
class MeayarRating extends StatelessWidget {
  const MeayarRating({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.onRatingChanged,
    this.starSize = 24.0,
    this.activeColor,
    this.inactiveColor,
    this.spacing = 4.0,
  });

  final double rating;
  final int maxRating;
  final ValueChanged<double>? onRatingChanged;
  final double starSize;
  final Color? activeColor;
  final Color? inactiveColor;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;

    final resolvedActive = activeColor ?? MeayarPrimitives.syrianGold500;
    final resolvedInactive = inactiveColor ?? colors.borderDefault;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxRating, (index) {
        final starIndex = index + 1;
        IconData icon;
        Color color;

        if (rating >= starIndex) {
          icon = MeayarIcons.star;
          color = resolvedActive;
        } else if (rating >= starIndex - 0.5) {
          icon = MeayarIcons.starHalf;
          color = resolvedActive;
        } else {
          icon = MeayarIcons.starOutline;
          color = resolvedInactive;
        }

        final star = Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: Icon(icon, size: starSize, color: color),
        );

        if (onRatingChanged != null) {
          return InkWell(
            onTap: () => onRatingChanged!(starIndex.toDouble()),
            customBorder: const CircleBorder(),
            child: star,
          );
        }

        return star;
      }),
    );
  }
}
