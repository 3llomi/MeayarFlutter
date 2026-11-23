/// Pure Dart Hijri Date representation and Gregorian <-> Hijri converter.
class HijriDate {
  HijriDate({
    required this.hYear,
    required this.hMonth,
    required this.hDay,
  });

  final int hYear;
  final int hMonth; // 1-12
  final int hDay;   // 1-30

  static const List<String> arabicMonths = [
    'محرم',
    'صفر',
    'ربيع الأول',
    'ربيع الآخر',
    'جمادى الأولى',
    'جمادى الآخرة',
    'رجب',
    'شعبان',
    'رمضان',
    'شوال',
    'ذو القعدة',
    'ذو الحجة',
  ];

  static const List<String> englishMonths = [
    'Muharram',
    'Safar',
    'Rabi\' al-Awwal',
    'Rabi\' al-Thani',
    'Jumada al-Ula',
    'Jumada al-Akhirah',
    'Rajab',
    'Sha\'ban',
    'Ramadan',
    'Shawwal',
    'Dhu al-Qi\'dah',
    'Dhu al-Hijjah',
  ];

  String get monthNameArabic => arabicMonths[(hMonth - 1).clamp(0, 11)];
  String get monthNameEnglish => englishMonths[(hMonth - 1).clamp(0, 11)];

  /// Converts a Gregorian DateTime into a HijriDate
  factory HijriDate.fromGregorian(DateTime date) {
    final jd = _gregorianToJulianDay(date.year, date.month, date.day);
    return _julianDayToHijri(jd);
  }

  /// Converts this HijriDate back to a Gregorian DateTime
  DateTime toGregorian() {
    final jd = _hijriToJulianDay(hYear, hMonth, hDay);
    return _julianDayToGregorian(jd);
  }

  /// Gets the number of days in a given Hijri month
  static int getDaysInMonth(int year, int month) {
    if (month < 1 || month > 12) return 30;
    // Alternate months generally have 30 and 29 days, with leap year adjustment in 12th month
    if (month == 12) {
      final isLeap = ((11 * year + 14) % 30) < 11;
      return isLeap ? 30 : 29;
    }
    return month % 2 == 1 ? 30 : 29;
  }

  static double _gregorianToJulianDay(int year, int month, int day) {
    if (month <= 2) {
      year -= 1;
      month += 12;
    }
    final a = (year / 100).floor();
    final b = 2 - a + (a / 4).floor();
    return (365.25 * (year + 4716)).floor() +
        (30.6001 * (month + 1)).floor() +
        day +
        b -
        1524.5;
  }

  static DateTime _julianDayToGregorian(double jd) {
    final z = (jd + 0.5).floor();
    final f = (jd + 0.5) - z;
    int a;
    if (z < 2299161) {
      a = z;
    } else {
      final alpha = ((z - 1867216.25) / 36524.25).floor();
      a = z + 1 + alpha - (alpha / 4).floor();
    }
    final b = a + 1524;
    final c = ((b - 122.1) / 365.25).floor();
    final d = (365.25 * c).floor();
    final e = ((b - d) / 30.6001).floor();

    final day = b - d - (30.6001 * e).floor() + f;
    final month = e < 14 ? e - 1 : e - 13;
    final year = month > 2 ? c - 4716 : c - 4715;

    return DateTime(year, month, day.floor());
  }

  static HijriDate _julianDayToHijri(double jd) {
    final l = (jd + 0.5).floor() - 1948440 + 10632;
    final n = ((l - 1) / 10631).floor();
    final l2 = l - 10631 * n + 354;
    final j = ((10985 - l2) / 5316).floor() * ((50 * l2) / 17719).floor() +
        (l2 / 5670).floor() * ((43 * l2) / 15238).floor();
    final l3 = l2 -
        ((30 - j) / 15).floor() * ((17719 * j) / 50).floor() -
        (j / 16).floor() * ((15238 * j) / 43).floor() +
        29;
    final m = ((24 * l3) / 709).floor();
    final d = l3 - ((709 * m) / 24).floor();
    final y = 30 * n + j - 30;

    return HijriDate(
      hYear: y,
      hMonth: m.clamp(1, 12),
      hDay: d.clamp(1, 30),
    );
  }

  static double _hijriToJulianDay(int year, int month, int day) {
    return ((11 * year + 3) / 30).floor() +
        354 * year +
        30 * month -
        ((month - 1) / 2).floor() +
        day +
        1948440 -
        385;
  }

  String format({bool inArabic = true}) {
    final m = inArabic ? monthNameArabic : monthNameEnglish;
    final suffix = inArabic ? 'هـ' : 'AH';
    return '$hDay $m $hYear $suffix';
  }

  @override
  String toString() => '$hYear-$hMonth-$hDay AH';
}
