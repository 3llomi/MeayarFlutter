import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
import '../../core/utils/hijri_date.dart';
import '../feedback/meayar_dialog.dart';
import '../inputs/meayar_form_field_wrapper.dart';
import 'meayar_calendar.dart';

/// Official MEAYAR Date Picker input component.
/// Displays an interactive input box that opens a modal calendar on tap.
/// Full support for Gregorian & Islamic Hijri calendars.
/// Follows system/app ambient locale for calendar formatting with support for explicit custom [Locale].
/// UI labels and action buttons default to authentic Arabic.
class MeayarDatePicker extends StatelessWidget {
  const MeayarDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.label,
    this.isMandatory = false,
    this.placeholder = 'اختر التاريخ...',
    this.dialogTitle,
    this.confirmButtonText = 'تأكيد',
    this.cancelButtonText = 'إلغاء',
    this.confirmText,
    this.cancelText,
    this.helperText,
    this.errorMessage,
    this.isError = false,
    this.enabled = true,
    this.calendarType = MeayarCalendarType.gregorian,
    this.locale,
    this.firstDayOfWeek,
    this.customMonthNames,
    this.customWeekdayLabels,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final String? label;
  final bool isMandatory;
  final String placeholder;
  final String? dialogTitle;
  final String confirmButtonText;
  final String cancelButtonText;
  final String? confirmText;
  final String? cancelText;
  final String? helperText;
  final String? errorMessage;
  final bool isError;
  final bool enabled;
  final MeayarCalendarType calendarType;
  final Locale? locale;
  final int? firstDayOfWeek;
  final List<String>? customMonthNames;
  final List<String>? customWeekdayLabels;

  Locale _getEffectiveLocale(BuildContext context) {
    if (locale != null) {
      return locale!;
    }
    return View.maybeOf(context)?.platformDispatcher.locale ??
        WidgetsBinding.instance.platformDispatcher.locale;
  }

  String _formatDate(DateTime date, Locale locale) {
    if (calendarType == MeayarCalendarType.hijri) {
      final h = HijriDate.fromGregorian(date);
      return '${h.hYear}/${h.hMonth.toString().padLeft(2, '0')}/${h.hDay.toString().padLeft(2, '0')}';
    }
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  void _showCalendarDialog(BuildContext context, Locale effectiveLocale) {
    FocusScope.of(context).unfocus();
    DateTime tempDate = selectedDate ?? DateTime.now();
    final isHijri = calendarType == MeayarCalendarType.hijri;

    final effectiveDialogTitle = dialogTitle ??
        (isHijri ? 'اختيار التاريخ الهجري' : 'اختيار التاريخ');
    final effectiveConfirm = confirmText ?? confirmButtonText;
    final effectiveCancel = cancelText ?? cancelButtonText;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return MeayarDialog(
              title: effectiveDialogTitle,
              confirmText: effectiveConfirm,
              cancelText: effectiveCancel,
              onConfirm: () {
                Navigator.of(dialogContext).pop();
                onDateSelected(tempDate);
              },
              onCancel: () {
                Navigator.of(dialogContext).pop();
              },
              content: MeayarCalendar(
                selectedDate: tempDate,
                calendarType: calendarType,
                locale: effectiveLocale,
                firstDayOfWeek: firstDayOfWeek,
                customMonthNames: customMonthNames,
                customWeekdayLabels: customWeekdayLabels,
                showBorder: false,
                onDateSelected: (newDate) {
                  setDialogState(() {
                    tempDate = newDate;
                  });
                },
              ),
            );
          },
        );
      },
    ).then((_) {
      FocusManager.instance.primaryFocus?.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final effectiveLocale = _getEffectiveLocale(context);
    final effectivePlaceholder = placeholder;

    final hasError = isError || (errorMessage != null && errorMessage!.isNotEmpty);
    final borderColor = !enabled
        ? colors.borderSubtle
        : hasError
            ? colors.borderError
            : colors.borderDefault;

    return MeayarFormFieldWrapper(
      label: label,
      isMandatory: isMandatory,
      helperText: helperText,
      errorMessage: errorMessage,
      isError: isError,
      enabled: enabled,
      child: InkWell(
        onTap: enabled ? () => _showCalendarDialog(context, effectiveLocale) : null,
        borderRadius: meayar.shapes.small,
        child: Container(
          height: 44.0,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: enabled ? colors.backgroundSubtle : colors.backgroundDisabled,
            borderRadius: meayar.shapes.small,
            border: Border.all(color: borderColor, width: hasError ? 1.5 : 1.0),
          ),
          child: Row(
            children: [
              Icon(
                MeayarIcons.calendar,
                color: enabled ? colors.iconSecondary : colors.iconDisabled,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  selectedDate != null ? _formatDate(selectedDate!, effectiveLocale) : effectivePlaceholder,
                  style: typography.textSm.copyWith(
                    color: selectedDate != null
                        ? (enabled ? colors.textPrimary : colors.textDisabled)
                        : colors.textDisabled,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
