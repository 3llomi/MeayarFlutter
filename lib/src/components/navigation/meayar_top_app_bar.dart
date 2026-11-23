import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
import '../buttons/meayar_button.dart';

/// Official MEAYAR Mobile Top App Bar.
/// Implements [PreferredSizeWidget] for direct use as `appBar` in [Scaffold].
/// Direction-aware back button automatic mirroring for Arabic RTL and English LTR.
class MeayarTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MeayarTopAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onNavigationClick,
    this.actions,
    this.elevation = 0.0,
    this.bottom,
    this.centerTitle = false,
    this.backgroundColor,
    this.useSafeArea = true,
    this.showBottomBorder = true,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onNavigationClick;
  final List<Widget>? actions;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final bool centerTitle;
  final Color? backgroundColor;
  final bool useSafeArea;
  final bool showBottomBorder;

  @override
  Size get preferredSize => Size.fromHeight(
        56.0 + (bottom?.preferredSize.height ?? 0.0),
      );

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final canPop = Navigator.canPop(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && (canPop || onNavigationClick != null)) {
      effectiveLeading = IconButton(
        icon: Icon(
          isRtl ? MeayarIcons.arrowForward : MeayarIcons.arrowBack,
          color: colors.iconPrimary,
        ),
        tooltip: 'رجوع',
        onPressed: onNavigationClick ?? () => Navigator.maybePop(context),
      );
    }

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 56.0,
          child: Row(
            children: [
              ?effectiveLeading,
              const SizedBox(width: 4.0),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: centerTitle ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: typography.textMdBold.copyWith(color: colors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2.0),
                      Text(
                        subtitle!,
                        style: typography.text2xs.copyWith(color: colors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (actions != null) ...actions!,
              const SizedBox(width: 4.0),
            ],
          ),
        ),
        ?bottom,
      ],
    );

    return Material(
      color: backgroundColor ?? colors.backgroundSurface,
      elevation: elevation,
      child: Container(
        decoration: BoxDecoration(
          border: showBottomBorder
              ? Border(bottom: BorderSide(color: colors.borderSubtle, width: 1.0))
              : null,
        ),
        child: useSafeArea
            ? SafeArea(
                bottom: false,
                child: content,
              )
            : content,
      ),
    );
  }
}

/// Convenience icon-only button for app bar actions.
class MeayarIconButton extends StatelessWidget {
  const MeayarIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.size = MeayarButtonSize.md,
    this.variant = MeayarButtonVariant.ghost,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final Widget icon;
  final MeayarButtonSize size;
  final MeayarButtonVariant variant;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final specs = MeayarButtonSpecs.get(size);
    final fg = variant == MeayarButtonVariant.ghost ? meayar.colors.iconSecondary : null;

    return SizedBox(
      width: specs.height,
      height: specs.height,
      child: MeayarButton(
        onPressed: enabled ? onPressed : null,
        size: size,
        variant: variant,
        foregroundColor: fg,
        padding: EdgeInsets.zero,
        child: Center(child: icon),
      ),
    );
  }
}
