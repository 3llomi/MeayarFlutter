import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

/// Official MEAYAR Tooltip component.
/// Can be rendered as a standalone visual bubble (`text` + optional `icon`),
/// or as an interactive wrapper around a `child` widget with hover/long-press behavior.
class MeayarTooltip extends StatelessWidget {
  const MeayarTooltip({
    super.key,
    this.text,
    this.message,
    this.icon,
    this.child,
    this.backgroundColor,
    this.contentColor,
    this.waitDuration = const Duration(milliseconds: 500),
  }) : assert(text != null || message != null, 'Either text or message must be provided');

  final String? text;
  final String? message;
  final IconData? icon;
  final Widget? child;
  final Color? backgroundColor;
  final Color? contentColor;
  final Duration waitDuration;

  String get _effectiveText => text ?? message!;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final bg = backgroundColor ?? colors.backgroundInverse;
    final fg = contentColor ?? colors.textInverse;

    final bubble = Material(
      color: bg,
      borderRadius: BorderRadius.circular(6.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14.0, color: fg),
              const SizedBox(width: 6.0),
            ],
            Text(
              _effectiveText,
              style: typography.textXsMedium.copyWith(color: fg),
            ),
          ],
        ),
      ),
    );

    if (child == null) {
      return bubble;
    }

    return Tooltip(
      message: _effectiveText,
      waitDuration: waitDuration,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      textStyle: typography.textXsMedium.copyWith(color: fg),
      child: child!,
    );
  }
}

/// Interactive Tooltip Anchor Box that reveals a tooltip bubble on click.
class MeayarTooltipBox extends StatefulWidget {
  const MeayarTooltipBox({
    super.key,
    required this.tooltipText,
    this.icon,
    required this.child,
  });

  final String tooltipText;
  final IconData? icon;
  final Widget child;

  @override
  State<MeayarTooltipBox> createState() => _MeayarTooltipBoxState();
}

class _MeayarTooltipBoxState extends State<MeayarTooltipBox> {
  OverlayEntry? _overlayEntry;

  void _showTooltip() {
    if (_overlayEntry != null) {
      _hideTooltip();
      return;
    }

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;
    final top = (offset.dy - 38.0).clamp(8.0, screenSize.height - 40.0);
    final left = offset.dx.clamp(8.0, (screenSize.width - 200.0).clamp(8.0, double.infinity));

    _overlayEntry = OverlayEntry(
      builder: (context) => Listener(
        behavior: HitTestBehavior.translucent,
        onPointerDown: (_) => _hideTooltip(),
        child: Stack(
          children: [
            Positioned(
              left: left,
              top: top,
              child: MeayarTooltip(
                text: widget.tooltipText,
                icon: widget.icon,
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showTooltip,
      child: widget.child,
    );
  }
}
