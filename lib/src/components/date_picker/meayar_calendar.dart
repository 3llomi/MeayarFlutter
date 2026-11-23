import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' hide TextDirection;
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
import '../../core/utils/hijri_date.dart';

enum MeayarCalendarType {
  gregorian,
  hijri,
}

enum _CalendarViewMode {
  days,
  months,
  years,
}

/// Official MEAYAR Inline Calendar component.
/// Fully supports both Gregorian and Islamic Hijri calendars.
/// Follows system/app ambient locale with support for explicit custom [Locale].
/// Uses native Row/Column layout without internal Scrollables to prevent gesture arena conflicts.
class MeayarCalendar extends StatefulWidget {
  const MeayarCalendar({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.calendarType = MeayarCalendarType.gregorian,
    this.locale,
    this.firstDayOfWeek,
    this.showBorder = true,
    this.customMonthNames,
    this.customWeekdayLabels,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final MeayarCalendarType calendarType;
  final Locale? locale;
  final int? firstDayOfWeek;
  final bool showBorder;
  final List<String>? customMonthNames;
  final List<String>? customWeekdayLabels;

  /// Official Syrian / Levantine Gregorian month names (الشهور المشرقية السورية).
  ///
  /// NOTE: This fallback list is used because Dart's `package:intl` and Flutter's
  /// CLDR dataset do not currently support `ar_SY` or Levantine month names.
  /// `intl` only includes `ar`, `ar_EG`, and `ar_DZ`, aliasing `ar_SY` to `ar`
  /// (which produces Egyptian/Gulf names like 'يناير' and 'فبراير' instead of
  /// 'كانون الثاني' and 'شباط'). All other locales are resolved dynamically.
  static const List<String> syrianGregorianMonths = [
    'كانون الثاني',
    'شباط',
    'آذار',
    'نيسان',
    'أيار',
    'حزيران',
    'تموز',
    'آب',
    'أيلول',
    'تشرين الأول',
    'تشرين الثاني',
    'كانون الأول',
  ];

  @override
  State<MeayarCalendar> createState() => _MeayarCalendarState();
}

class _MeayarCalendarState extends State<MeayarCalendar> {
  late int _displayYear;
  late int _displayMonth; // 1-12
  _CalendarViewMode _viewMode = _CalendarViewMode.days;
  ScrollController? _yearScrollController;

  void _ensureLocaleInitialized(String localeName) {
    try {
      initializeDateFormatting(localeName, null);
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    _initDisplayDates();
  }

  @override
  void didUpdateWidget(covariant MeayarCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate ||
        widget.calendarType != oldWidget.calendarType) {
      _initDisplayDates();
    }
  }

  @override
  void dispose() {
    _yearScrollController?.dispose();
    super.dispose();
  }

  void _openYearPicker() {
    final center = _displayYear;
    final years = List.generate(101, (i) => center - 50 + i);
    final initialIndex = years.indexOf(_displayYear);
    final scrollOffset = (initialIndex / 3).floor() * 52.0;

    _yearScrollController?.dispose();
    _yearScrollController = ScrollController(
      initialScrollOffset: scrollOffset.clamp(0.0, double.infinity),
    );
    setState(() {
      _viewMode = _CalendarViewMode.years;
    });
  }

  void _initDisplayDates() {
    if (widget.calendarType == MeayarCalendarType.hijri) {
      final h = HijriDate.fromGregorian(widget.selectedDate);
      _displayYear = h.hYear;
      _displayMonth = h.hMonth;
    } else {
      _displayYear = widget.selectedDate.year;
      _displayMonth = widget.selectedDate.month;
    }
  }

  Locale _getEffectiveLocale(BuildContext context) {
    if (widget.locale != null) {
      return widget.locale!;
    }
    return View.maybeOf(context)?.platformDispatcher.locale ??
        WidgetsBinding.instance.platformDispatcher.locale;
  }

  int _getEffectiveFirstDayOfWeek(BuildContext context, Locale locale) {
    if (widget.firstDayOfWeek != null) {
      return widget.firstDayOfWeek!;
    }
    if (locale.languageCode == 'ar') {
      return DateTime.saturday; // 6 = Saturday in Syrian & Arab calendars
    }
    final matLoc = Localizations.of<MaterialLocalizations>(context, MaterialLocalizations);
    final ambientLocale = Localizations.maybeLocaleOf(context);
    if (matLoc != null && ambientLocale?.languageCode == locale.languageCode) {
      final idx = matLoc.firstDayOfWeekIndex;
      return idx == 0 ? DateTime.sunday : idx;
    }
    return DateTime.sunday; // 7 = Sunday in US / Western conventions
  }

  List<String> _getWeekdayLabels(BuildContext context, Locale locale, int firstDay) {
    if (widget.customWeekdayLabels != null && widget.customWeekdayLabels!.length >= 7) {
      return widget.customWeekdayLabels!;
    }
    final localeName = locale.toString();
    _ensureLocaleInitialized(localeName);
    return List.generate(7, (i) {
      final dayOfWeek = ((firstDay - 1 + i) % 7) + 1;
      final sampleDay = dayOfWeek == DateTime.sunday ? 1 : dayOfWeek + 1;
      final sampleDate = DateTime(2026, 11, sampleDay);
      try {
        return DateFormat.EEEEE(localeName).format(sampleDate);
      } catch (_) {
        try {
          return DateFormat.EEEEE(locale.languageCode).format(sampleDate);
        } catch (_) {
          final isArabic = locale.languageCode == 'ar';
          switch (dayOfWeek) {
            case DateTime.saturday:
              return isArabic ? 'س' : 'S';
            case DateTime.sunday:
              return isArabic ? 'ح' : 'S';
            case DateTime.monday:
              return isArabic ? 'ن' : 'M';
            case DateTime.tuesday:
              return isArabic ? 'ث' : 'T';
            case DateTime.wednesday:
              return isArabic ? 'ر' : 'W';
            case DateTime.thursday:
              return isArabic ? 'خ' : 'T';
            case DateTime.friday:
              return isArabic ? 'ج' : 'F';
            default:
              return '';
          }
        }
      }
    });
  }

  String _getMonthName(int month, Locale locale) {
    final idx = (month - 1).clamp(0, 11);
    if (widget.customMonthNames != null && widget.customMonthNames!.length >= 12) {
      return widget.customMonthNames![idx];
    }
    if (widget.calendarType == MeayarCalendarType.hijri) {
      if (locale.languageCode == 'ar') {
        return HijriDate.arabicMonths[idx];
      }
      return HijriDate.englishMonths[idx];
    }

    // Gregorian calendar
    // 1. Syrian / Levantine Arabic month names for Syrian national identity (countryCode SY).
    // Used explicitly because Dart intl CLDR dataset does not support ar_SY and aliases it to ar (يناير / فبراير).
    if (locale.languageCode == 'ar' && locale.countryCode?.toUpperCase() == 'SY') {
      return MeayarCalendar.syrianGregorianMonths[idx];
    }

    // 2. Dynamic localization from DateFormat for ALL locales (e.g. ar_EG -> نوفمبر, en_EG -> November, fr -> novembre, etc.)
    final date = DateTime(_displayYear, month, 1);
    final localeName = locale.toString();
    _ensureLocaleInitialized(localeName);
    try {
      return DateFormat.MMMM(localeName).format(date);
    } catch (_) {
      try {
        final languageCode = locale.languageCode;
        _ensureLocaleInitialized(languageCode);
        return DateFormat.MMMM(languageCode).format(date);
      } catch (_) {
        try {
          return DateFormat.MMMM('en').format(date);
        } catch (_) {
          return '$month';
        }
      }
    }
  }

  int _getDaysInMonth(int year, int month) {
    if (widget.calendarType == MeayarCalendarType.hijri) {
      return HijriDate.getDaysInMonth(year, month);
    }
    return DateUtils.getDaysInMonth(year, month);
  }

  void _prevMonth() {
    setState(() {
      if (_displayMonth == 1) {
        _displayMonth = 12;
        _displayYear--;
      } else {
        _displayMonth--;
      }
    });
  }

  void _nextMonth() {
    setState(() {
      if (_displayMonth == 12) {
        _displayMonth = 1;
        _displayYear++;
      } else {
        _displayMonth++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final effectiveLocale = _getEffectiveLocale(context);
    final firstDayOfWeek = _getEffectiveFirstDayOfWeek(context, effectiveLocale);
    final prevIcon = MeayarIcons.chevronLeft;
    final nextIcon = MeayarIcons.chevronRight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: colors.backgroundSurface,
        borderRadius: meayar.shapes.medium,
        border: widget.showBorder
            ? Border.all(color: colors.borderSubtle, width: 1.0)
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header: Month & Year navigation + separate mode toggles
          Row(
            children: [
              // Previous Month button (active only in Days view, fixed 36dp)
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(minWidth: 36.0, minHeight: 36.0),
                iconSize: 20.0,
                icon: Icon(prevIcon),
                onPressed: _viewMode == _CalendarViewMode.days ? _prevMonth : null,
                tooltip: effectiveLocale.languageCode == 'ar' ? 'الشهر السابق' : 'Previous Month',
                color: _viewMode == _CalendarViewMode.days ? colors.iconPrimary : Colors.transparent,
              ),

              // Month & Year clickable dropdown selectors (takes center space)
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Month Picker Pill
                    Flexible(
                      child: Material(
                        color: _viewMode == _CalendarViewMode.months
                            ? colors.backgroundBrandSubtle
                            : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _viewMode = _viewMode == _CalendarViewMode.months
                                  ? _CalendarViewMode.days
                                  : _CalendarViewMode.months;
                            });
                          },
                          borderRadius: BorderRadius.circular(8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    _getMonthName(_displayMonth, effectiveLocale),
                                    style: typography.textSmBold.copyWith(
                                      color: _viewMode == _CalendarViewMode.months
                                          ? colors.textBrand
                                          : colors.textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 3.0),
                                RotatedBox(
                                  quarterTurns: _viewMode == _CalendarViewMode.months ? 2 : 0,
                                  child: Icon(
                                    MeayarIcons.chevronDown,
                                    size: 14.0,
                                    color: _viewMode == _CalendarViewMode.months
                                        ? colors.iconBrand
                                        : colors.iconSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 4.0),

                    // Year Picker Pill
                    Material(
                      color: _viewMode == _CalendarViewMode.years
                          ? colors.backgroundBrandSubtle
                          : Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (_viewMode == _CalendarViewMode.years) {
                            setState(() => _viewMode = _CalendarViewMode.days);
                          } else {
                            _openYearPicker();
                          }
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$_displayYear',
                                style: typography.textSmBold.copyWith(
                                  color: _viewMode == _CalendarViewMode.years
                                      ? colors.textBrand
                                      : colors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 3.0),
                              RotatedBox(
                                quarterTurns: _viewMode == _CalendarViewMode.years ? 2 : 0,
                                child: Icon(
                                  MeayarIcons.chevronDown,
                                  size: 14.0,
                                  color: _viewMode == _CalendarViewMode.years
                                      ? colors.iconBrand
                                      : colors.iconSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Next Month button (active only in Days view, fixed 36dp)
              IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(minWidth: 36.0, minHeight: 36.0),
                iconSize: 20.0,
                icon: Icon(nextIcon),
                onPressed: _viewMode == _CalendarViewMode.days ? _nextMonth : null,
                tooltip: effectiveLocale.languageCode == 'ar' ? 'الشهر التالي' : 'Next Month',
                color: _viewMode == _CalendarViewMode.days ? colors.iconPrimary : Colors.transparent,
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Body View
          if (_viewMode == _CalendarViewMode.days)
            _buildDaysGrid(context, effectiveLocale, firstDayOfWeek)
          else if (_viewMode == _CalendarViewMode.months)
            _buildMonthsGrid(context, effectiveLocale)
          else
            _buildYearsGrid(context),
        ],
      ),
    );
  }

  Widget _buildDaysGrid(BuildContext context, Locale effectiveLocale, int firstDayOfWeek) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final daysInMonth = _getDaysInMonth(_displayYear, _displayMonth);

    // Compute start day offset
    int firstWeekday;
    if (widget.calendarType == MeayarCalendarType.hijri) {
      final gDate = HijriDate(hYear: _displayYear, hMonth: _displayMonth, hDay: 1).toGregorian();
      firstWeekday = gDate.weekday; // 1 = Monday ... 7 = Sunday
    } else {
      firstWeekday = DateTime(_displayYear, _displayMonth, 1).weekday;
    }

    final offset = (firstWeekday - firstDayOfWeek + 7) % 7;
    final totalCells = offset + daysInMonth;
    final numWeeks = (totalCells / 7.0).ceil();
    final weekdayLabels = _getWeekdayLabels(context, effectiveLocale, firstDayOfWeek);

    return Column(
      children: [
        // Day Names Header
        Row(
          children: List.generate(7, (index) {
            return Expanded(
              child: Center(
                child: Text(
                  weekdayLabels[index],
                  style: typography.textXsMedium.copyWith(color: colors.textTertiary),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8.0),

        // Grid of Days as pure Rows (No inner Scrollables!)
        ...List.generate(numWeeks, (weekIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              children: List.generate(7, (dayCol) {
                final cellIndex = weekIndex * 7 + dayCol;
                if (cellIndex < offset || cellIndex >= totalCells) {
                  return const Expanded(child: SizedBox(height: 38.0));
                }

                final day = cellIndex - offset + 1;
                bool isSelected;

                if (widget.calendarType == MeayarCalendarType.hijri) {
                  final hSelected = HijriDate.fromGregorian(widget.selectedDate);
                  isSelected = hSelected.hYear == _displayYear &&
                      hSelected.hMonth == _displayMonth &&
                      hSelected.hDay == day;
                } else {
                  isSelected = widget.selectedDate.year == _displayYear &&
                      widget.selectedDate.month == _displayMonth &&
                      widget.selectedDate.day == day;
                }

                return Expanded(
                  child: SizedBox(
                    height: 38.0,
                    child: InkWell(
                      onTap: () {
                        DateTime selected;
                        if (widget.calendarType == MeayarCalendarType.hijri) {
                          selected = HijriDate(hYear: _displayYear, hMonth: _displayMonth, hDay: day)
                              .toGregorian();
                        } else {
                          selected = DateTime(_displayYear, _displayMonth, day);
                        }
                        widget.onDateSelected(selected);
                      },
                      borderRadius: meayar.shapes.pill,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? colors.backgroundBrand : Colors.transparent,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$day',
                          style: typography.textSmMedium.copyWith(
                            color: isSelected ? colors.textInverse : colors.textPrimary,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ],
    );
  }

  void _selectMonth(int month) {
    DateTime newSelectedDate;
    if (widget.calendarType == MeayarCalendarType.hijri) {
      final h = HijriDate.fromGregorian(widget.selectedDate);
      final maxDays = HijriDate.getDaysInMonth(_displayYear, month);
      final day = h.hDay.clamp(1, maxDays);
      newSelectedDate = HijriDate(hYear: _displayYear, hMonth: month, hDay: day).toGregorian();
    } else {
      final maxDays = DateUtils.getDaysInMonth(_displayYear, month);
      final day = widget.selectedDate.day.clamp(1, maxDays);
      newSelectedDate = DateTime(_displayYear, month, day);
    }

    setState(() {
      _displayMonth = month;
      _viewMode = _CalendarViewMode.days;
    });

    widget.onDateSelected(newSelectedDate);
  }

  void _selectYear(int year) {
    DateTime newSelectedDate;
    if (widget.calendarType == MeayarCalendarType.hijri) {
      final h = HijriDate.fromGregorian(widget.selectedDate);
      final maxDays = HijriDate.getDaysInMonth(year, h.hMonth);
      final day = h.hDay.clamp(1, maxDays);
      newSelectedDate = HijriDate(hYear: year, hMonth: h.hMonth, hDay: day).toGregorian();
    } else {
      final maxDays = DateUtils.getDaysInMonth(year, _displayMonth);
      final day = widget.selectedDate.day.clamp(1, maxDays);
      newSelectedDate = DateTime(year, _displayMonth, day);
    }

    setState(() {
      _displayYear = year;
      _viewMode = _CalendarViewMode.days;
    });

    widget.onDateSelected(newSelectedDate);
  }

  Widget _buildMonthsGrid(BuildContext context, Locale effectiveLocale) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return SizedBox(
      height: 250.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(4, (rowIndex) {
          return Row(
            children: List.generate(3, (colIndex) {
              final month = rowIndex * 3 + colIndex + 1;
              final isSelected = _displayMonth == month;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  child: InkWell(
                    onTap: () => _selectMonth(month),
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: 48.0,
                      decoration: BoxDecoration(
                        color: isSelected ? colors.backgroundBrand : colors.backgroundSubtle,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: isSelected ? colors.borderBrand : colors.borderSubtle,
                          width: 1.0,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _getMonthName(month, effectiveLocale),
                        style: (isSelected ? typography.textSmBold : typography.textSm).copyWith(
                          color: isSelected ? colors.textInverse : colors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }

  Widget _buildYearsGrid(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final center = _displayYear;
    final years = List.generate(101, (i) => center - 50 + i);

    return SizedBox(
      height: 250.0,
      child: GridView.builder(
        controller: _yearScrollController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          mainAxisExtent: 44.0,
        ),
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final isSelected = _displayYear == year;

          return InkWell(
            onTap: () => _selectYear(year),
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? colors.backgroundBrand : colors.backgroundSubtle,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: isSelected ? colors.borderBrand : colors.borderSubtle,
                  width: 1.0,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '$year',
                style: (isSelected ? typography.textSmBold : typography.textSm).copyWith(
                  color: isSelected ? colors.textInverse : colors.textPrimary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
