import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';
import 'meayar_form_field_wrapper.dart';

/// Official MEAYAR Input / Text Field widget.
/// Conforms to Syrian design guidelines:
/// - Label with optional mandatory (*) indicator
/// - Semantic helper and error texts
/// - Direction-aware typing with [forceLtrContent] for phone numbers, IBANs, URLs, etc.
/// - Leading and trailing icon slots
class MeayarTextField extends StatefulWidget {
  const MeayarTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.label,
    this.isMandatory = false,
    this.placeholder,
    this.helperText,
    this.errorMessage,
    this.isError = false,
    this.enabled = true,
    this.readOnly = false,
    this.forceLtrContent = false,
    this.obscureText = false,
    this.leading,
    this.trailing,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
    this.maxLines = 1,
    this.minLines,
    this.borderRadius,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? label;
  final bool isMandatory;
  final String? placeholder;
  final String? helperText;
  final String? errorMessage;
  final bool isError;
  final bool enabled;
  final bool readOnly;
  final bool forceLtrContent;
  final bool obscureText;
  final Widget? leading;
  final Widget? trailing;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final int? maxLines;
  final int? minLines;
  final BorderRadius? borderRadius;

  @override
  State<MeayarTextField> createState() => _MeayarTextFieldState();
}

class _MeayarTextFieldState extends State<MeayarTextField> {
  FocusNode? _internalFocusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_internalFocusNode ??= FocusNode());
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _effectiveFocusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant MeayarTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _internalFocusNode)?.removeListener(_handleFocusChange);
      _effectiveFocusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_handleFocusChange);
    _internalFocusNode?.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) {
      setState(() {
        _isFocused = _effectiveFocusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final hasError = widget.isError || (widget.errorMessage != null && widget.errorMessage!.isNotEmpty);

    Color borderColor;
    double borderWidth;

    if (!widget.enabled) {
      borderColor = colors.borderSubtle;
      borderWidth = 1.0;
    } else if (hasError) {
      borderColor = colors.borderError;
      borderWidth = 1.5;
    } else if (_isFocused) {
      borderColor = colors.borderFocus;
      borderWidth = 1.5;
    } else {
      borderColor = colors.borderDefault;
      borderWidth = 1.0;
    }

    final effectiveRadius = widget.borderRadius ?? meayar.shapes.small;

    return MeayarFormFieldWrapper(
      label: widget.label,
      isMandatory: widget.isMandatory,
      helperText: widget.helperText,
      errorMessage: widget.errorMessage,
      isError: widget.isError,
      enabled: widget.enabled,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: widget.enabled ? colors.backgroundSubtle : colors.backgroundDisabled,
          borderRadius: effectiveRadius,
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.leading != null) ...[
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 12.0),
                child: IconTheme(
                  data: IconThemeData(
                    color: widget.enabled ? colors.iconSecondary : colors.iconDisabled,
                    size: 20.0,
                  ),
                  child: widget.leading!,
                ),
              ),
            ],
            Expanded(
              child: Directionality(
                textDirection: widget.forceLtrContent
                    ? TextDirection.ltr
                    : Directionality.of(context),
                child: TextFormField(
                  controller: widget.controller,
                  initialValue: widget.controller == null ? widget.initialValue : null,
                  focusNode: _effectiveFocusNode,
                  onChanged: widget.onChanged,
                  onFieldSubmitted: widget.onSubmitted,
                  enabled: widget.enabled,
                  readOnly: widget.readOnly,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  maxLines: widget.obscureText ? 1 : widget.maxLines,
                  minLines: widget.minLines,
                  style: typography.textSm.copyWith(
                    color: widget.enabled ? colors.textPrimary : colors.textDisabled,
                  ),
                  cursorColor: colors.borderFocus,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.placeholder,
                    hintStyle: typography.textSm.copyWith(color: colors.textDisabled),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                ),
              ),
            ),
            if (widget.trailing != null) ...[
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12.0),
                child: IconTheme(
                  data: IconThemeData(
                    color: widget.enabled ? colors.iconSecondary : colors.iconDisabled,
                    size: 20.0,
                  ),
                  child: widget.trailing!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
