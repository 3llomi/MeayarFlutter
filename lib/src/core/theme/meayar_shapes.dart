import 'package:flutter/material.dart';

/// MEAYAR (معيار) Design System Corner Radiuses and Shapes.
@immutable
class MeayarShapes {
  const MeayarShapes({
    this.none = BorderRadius.zero,
    this.extraSmall = const BorderRadius.all(Radius.circular(4.0)),
    this.small = const BorderRadius.all(Radius.circular(6.0)),
    this.medium = const BorderRadius.all(Radius.circular(10.0)),
    this.large = const BorderRadius.all(Radius.circular(12.0)),
    this.extraLarge = const BorderRadius.all(Radius.circular(18.0)),
    this.xxLarge = const BorderRadius.all(Radius.circular(24.0)),
    this.pill = const BorderRadius.all(Radius.circular(999.0)),
  });

  final BorderRadius none;
  final BorderRadius extraSmall;
  final BorderRadius small;
  final BorderRadius medium;
  final BorderRadius large;
  final BorderRadius extraLarge;
  final BorderRadius xxLarge;
  final BorderRadius pill;

  // Convenience shapes for Material 3 borders
  RoundedRectangleBorder get noneBorder => RoundedRectangleBorder(borderRadius: none);
  RoundedRectangleBorder get extraSmallBorder => RoundedRectangleBorder(borderRadius: extraSmall);
  RoundedRectangleBorder get smallBorder => RoundedRectangleBorder(borderRadius: small);
  RoundedRectangleBorder get mediumBorder => RoundedRectangleBorder(borderRadius: medium);
  RoundedRectangleBorder get largeBorder => RoundedRectangleBorder(borderRadius: large);
  RoundedRectangleBorder get extraLargeBorder => RoundedRectangleBorder(borderRadius: extraLarge);
  RoundedRectangleBorder get xxLargeBorder => RoundedRectangleBorder(borderRadius: xxLarge);
  RoundedRectangleBorder get pillBorder => RoundedRectangleBorder(borderRadius: pill);

  MeayarShapes lerp(MeayarShapes? other, double t) {
    if (other == null) return this;
    return MeayarShapes(
      none: BorderRadius.lerp(none, other.none, t)!,
      extraSmall: BorderRadius.lerp(extraSmall, other.extraSmall, t)!,
      small: BorderRadius.lerp(small, other.small, t)!,
      medium: BorderRadius.lerp(medium, other.medium, t)!,
      large: BorderRadius.lerp(large, other.large, t)!,
      extraLarge: BorderRadius.lerp(extraLarge, other.extraLarge, t)!,
      xxLarge: BorderRadius.lerp(xxLarge, other.xxLarge, t)!,
      pill: BorderRadius.lerp(pill, other.pill, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MeayarShapes &&
        other.none == none &&
        other.extraSmall == extraSmall &&
        other.small == small &&
        other.medium == medium &&
        other.large == large &&
        other.extraLarge == extraLarge &&
        other.xxLarge == xxLarge &&
        other.pill == pill;
  }

  @override
  int get hashCode => Object.hash(
        none,
        extraSmall,
        small,
        medium,
        large,
        extraLarge,
        xxLarge,
        pill,
      );
}
