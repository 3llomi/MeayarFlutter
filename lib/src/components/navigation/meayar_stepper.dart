import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';

class MeayarStep {
  const MeayarStep({
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
}

/// Official MEAYAR Stepper component for multi-step service applications.
class MeayarStepper extends StatelessWidget {
  const MeayarStepper({
    super.key,
    required this.steps,
    required this.currentStepIndex,
  });

  final List<MeayarStep> steps;
  final int currentStepIndex;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        final isCompleted = index < currentStepIndex;
        final isCurrent = index == currentStepIndex;
        final isLast = index == steps.length - 1;

        final circleColor = isCompleted
            ? colors.textSuccess
            : isCurrent
                ? colors.backgroundBrand
                : colors.backgroundDisabled;

        final circleFg = isCompleted || isCurrent ? colors.textInverse : colors.textTertiary;

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2.0,
                      color: index == 0
                          ? Colors.transparent
                          : (isCompleted || isCurrent
                              ? colors.backgroundBrand
                              : colors.borderSubtle),
                    ),
                  ),
                  Container(
                    width: 28.0,
                    height: 28.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: circleColor,
                    ),
                    alignment: Alignment.center,
                    child: isCompleted
                        ? Icon(MeayarIcons.check, size: 16.0, color: circleFg)
                        : Text(
                            '${index + 1}',
                            style: typography.textXsMedium.copyWith(color: circleFg),
                          ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2.0,
                      color: isLast
                          ? Colors.transparent
                          : (isCompleted
                              ? colors.backgroundBrand
                              : colors.borderSubtle),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                steps[index].title,
                textAlign: TextAlign.center,
                style: typography.textXsMedium.copyWith(
                  color: isCurrent || isCompleted ? colors.textPrimary : colors.textDisabled,
                  fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (steps[index].subtitle != null) ...[
                const SizedBox(height: 2.0),
                Text(
                  steps[index].subtitle!,
                  textAlign: TextAlign.center,
                  style: typography.text2xs.copyWith(color: colors.textTertiary),
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
