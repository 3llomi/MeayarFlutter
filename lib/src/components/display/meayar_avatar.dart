import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

enum MeayarAvatarSize {
  xs(24.0, 6.0),
  sm(32.0, 8.0),
  md(40.0, 10.0),
  lg(48.0, 12.0),
  xl(56.0, 14.0);

  const MeayarAvatarSize(this.dimension, this.indicatorSize);
  final double dimension;
  final double indicatorSize;
}

enum MeayarPresenceStatus {
  online,
  busy,
  offline,
}

/// Official MEAYAR Avatar widget supporting initials, images, and presence status indicators.
class MeayarAvatar extends StatelessWidget {
  const MeayarAvatar({
    super.key,
    required this.name,
    this.size = MeayarAvatarSize.md,
    this.status,
    this.image,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String name;
  final MeayarAvatarSize size;
  final MeayarPresenceStatus? status;
  final ImageProvider? image;
  final Color? backgroundColor;
  final Color? foregroundColor;

  String _getInitials(String input) {
    final parts = input.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.characters.take(2).toString();
    return '${parts[0].characters.first} ${parts[1].characters.first}';
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final initials = _getInitials(name);

    TextStyle textStyle;
    switch (size) {
      case MeayarAvatarSize.xs:
        textStyle = typography.text2xs;
        break;
      case MeayarAvatarSize.sm:
        textStyle = typography.textXsMedium;
        break;
      case MeayarAvatarSize.md:
        textStyle = typography.textSmMedium;
        break;
      case MeayarAvatarSize.lg:
        textStyle = typography.heading2xs;
        break;
      case MeayarAvatarSize.xl:
        textStyle = typography.headingXs;
        break;
    }

    final bg = backgroundColor ?? colors.backgroundBrandSubtle;
    final fg = foregroundColor ?? colors.textBrand;

    Widget avatarContent;
    if (image != null) {
      avatarContent = CircleAvatar(
        radius: size.dimension / 2,
        backgroundImage: image,
        backgroundColor: bg,
      );
    } else {
      avatarContent = Container(
        width: size.dimension,
        height: size.dimension,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg,
          border: Border.all(color: colors.borderSubtle, width: 1.0),
        ),
        alignment: Alignment.center,
        child: Text(
          initials,
          style: textStyle.copyWith(color: fg),
        ),
      );
    }

    if (status == null) return avatarContent;

    Color statusColor;
    switch (status!) {
      case MeayarPresenceStatus.online:
        statusColor = colors.tagGreenText;
        break;
      case MeayarPresenceStatus.busy:
        statusColor = colors.textError;
        break;
      case MeayarPresenceStatus.offline:
        statusColor = colors.textDisabled;
        break;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        avatarContent,
        PositionedDirectional(
          end: 0,
          bottom: 0,
          child: Container(
            width: size.indicatorSize,
            height: size.indicatorSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: statusColor,
              border: Border.all(color: colors.backgroundSurface, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

/// Displays an overlapping row of avatars.
class MeayarAvatarGroup extends StatelessWidget {
  const MeayarAvatarGroup({
    super.key,
    required this.avatars,
    this.overlap = 10.0,
  });

  final List<Widget> avatars;
  final double overlap;

  @override
  Widget build(BuildContext context) {
    if (avatars.isEmpty) return const SizedBox.shrink();

    final factor = (1.0 - (overlap / 40.0)).clamp(0.2, 0.95);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(avatars.length, (index) {
        final isLast = index == avatars.length - 1;
        return Align(
          widthFactor: isLast ? 1.0 : factor,
          alignment: AlignmentDirectional.centerStart,
          child: avatars[index],
        );
      }),
    );
  }
}
