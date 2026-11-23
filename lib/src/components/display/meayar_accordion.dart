import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';

/// Official MEAYAR Accordion / Expandable panel component.
class MeayarAccordion extends StatefulWidget {
  const MeayarAccordion({
    super.key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
    this.leading,
    this.subtitle,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius,
  });

  final String title;
  final Widget content;
  final bool initiallyExpanded;
  final Widget? leading;
  final String? subtitle;
  final EdgeInsetsGeometry padding;
  final BorderRadius? borderRadius;

  @override
  State<MeayarAccordion> createState() => _MeayarAccordionState();
}

class _MeayarAccordionState extends State<MeayarAccordion> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final shape = widget.borderRadius ?? meayar.shapes.medium;

    return Container(
      decoration: BoxDecoration(
        color: colors.backgroundSurface,
        borderRadius: shape,
        border: Border.all(color: colors.borderSubtle, width: 1.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: widget.padding,
              child: Row(
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: 12.0),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: typography.textSmMedium.copyWith(color: colors.textPrimary),
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 2.0),
                          Text(
                            widget.subtitle!,
                            style: typography.textXs.copyWith(color: colors.textTertiary),
                          ),
                        ],
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      MeayarIcons.chevronDown,
                      size: 20.0,
                      color: colors.iconSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Divider(color: colors.borderSubtle, height: 1.0),
                Padding(
                  padding: widget.padding,
                  child: widget.content,
                ),
              ],
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
