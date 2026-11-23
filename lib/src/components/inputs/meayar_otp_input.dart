import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/meayar_theme.dart';

/// Official MEAYAR OTP / PIN verification input.
/// Enforces LTR numeric layout so code digits flow left-to-right cleanly.
class MeayarOtpInput extends StatefulWidget {
  const MeayarOtpInput({
    super.key,
    required this.length,
    this.value = '',
    this.onChanged,
    this.onCompleted,
    this.enabled = true,
    this.isError = false,
    this.boxSize = 56.0,
    this.borderRadius,
  });

  final int length;
  final String value;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool enabled;
  final bool isError;
  final double boxSize;
  final BorderRadius? borderRadius;

  @override
  State<MeayarOtpInput> createState() => _MeayarOtpInputState();
}

class _MeayarOtpInputState extends State<MeayarOtpInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant MeayarOtpInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final effectiveRadius = widget.borderRadius ?? meayar.shapes.medium;

    final currentVal = _controller.text;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Hidden native TextField capturing keystrokes
            Opacity(
              opacity: 0.0,
              child: SizedBox(
                height: widget.boxSize,
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(widget.length),
                  ],
                  onChanged: (val) {
                    setState(() {});
                    widget.onChanged?.call(val);
                    if (val.length == widget.length) {
                      widget.onCompleted?.call(val);
                    }
                  },
                ),
              ),
            ),

            // Visual OTP Boxes
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.length, (index) {
                final isCurrent = _focusNode.hasFocus && index == currentVal.length;
                final isFilled = index < currentVal.length;
                final char = isFilled ? currentVal[index] : '';

                Color borderColor;
                double borderWidth;

                if (widget.isError) {
                  borderColor = colors.borderError;
                  borderWidth = 1.5;
                } else if (isCurrent) {
                  borderColor = colors.borderFocus;
                  borderWidth = 1.5;
                } else if (isFilled) {
                  borderColor = colors.borderBrand;
                  borderWidth = 1.0;
                } else {
                  borderColor = colors.borderDefault;
                  borderWidth = 1.0;
                }

                return Container(
                  width: widget.boxSize,
                  height: widget.boxSize,
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: widget.enabled ? colors.backgroundSubtle : colors.backgroundDisabled,
                    borderRadius: effectiveRadius,
                    border: Border.all(color: borderColor, width: borderWidth),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    char,
                    style: typography.headingXs.copyWith(
                      color: widget.isError
                          ? colors.textError
                          : (widget.enabled ? colors.textPrimary : colors.textDisabled),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
