import 'package:flutter/material.dart';
import '../../core/theme/meayar_theme.dart';

/// Shared layout wrapper for form input fields with label, mandatory indicator, and helper/error texts.
class MeayarFormFieldWrapper extends StatelessWidget {
  const MeayarFormFieldWrapper({
    super.key,
    required this.child,
    this.label,
    this.isMandatory = false,
    this.helperText,
    this.errorMessage,
    this.isError = false,
    this.enabled = true,
  });

  final Widget child;
  final String? label;
  final bool isMandatory;
  final String? helperText;
  final String? errorMessage;
  final bool isError;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final hasError = isError || (errorMessage != null && errorMessage!.isNotEmpty);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label!,
                style: typography.textSmMedium.copyWith(
                  color: enabled ? colors.textPrimary : colors.textDisabled,
                ),
              ),
              if (isMandatory) ...[
                const SizedBox(width: 4.0),
                Text('*', style: typography.textSmBold.copyWith(color: colors.textError)),
              ],
            ],
          ),
          const SizedBox(height: 6.0),
        ],
        child,
        if (hasError || (helperText != null && helperText!.isNotEmpty)) ...[
          const SizedBox(height: 4.0),
          Text(
            hasError ? (errorMessage ?? '') : helperText!,
            style: typography.textXs.copyWith(
              color: hasError ? colors.textError : colors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
