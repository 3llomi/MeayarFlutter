import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Centralized localization for MEAYAR (معيار) Design System components.
@immutable
class MeayarLocalizations {
  const MeayarLocalizations({
    required this.locale,
    required this.tableEmptyMessage,
    required this.paginationPrevious,
    required this.paginationNext,
    required this.dialogConfirm,
    required this.dialogCancel,
    required this.selectPlaceholder,
    required this.datePickerSelectDateGregorian,
    required this.datePickerSelectDateHijri,
    required this.datePickerPlaceholder,
    required this.fileUploadDropzoneTitle,
    required this.fileUploadDefaultHint,
    required this.fileUploadFailed,
    required this.cardStartService,
    required this.cardViewDetails,
    required this.cookieConsentTitle,
    required this.cookieConsentDescription,
    required this.cookieConsentAccept,
    required this.cookieConsentCustomize,
    required this.cookieConsentDecline,
    required this.cookieConsentSave,
    required this.cookieConsentNecessaryTitle,
    required this.cookieConsentAnalyticsTitle,
    required this.cookieConsentPreferencesTitle,
    required this.officialBannerTitle,
    required this.officialBannerSubtitle,
    required this.drawerHeaderTitle,
    required this.drawerHeaderSubtitle,
    required this.drawerFooterText,
    required this.drawerLogout,
  });

  final Locale locale;

  // Table
  final String tableEmptyMessage;

  // Pagination
  final String paginationPrevious;
  final String paginationNext;

  // Dialog
  final String dialogConfirm;
  final String dialogCancel;

  // Select
  final String selectPlaceholder;

  // Date Picker
  final String datePickerSelectDateGregorian;
  final String datePickerSelectDateHijri;
  final String datePickerPlaceholder;

  // File Upload
  final String fileUploadDropzoneTitle;
  final String fileUploadDefaultHint;
  final String fileUploadFailed;

  // Card / Portal
  final String cardStartService;
  final String cardViewDetails;

  // Cookie Consent
  final String cookieConsentTitle;
  final String cookieConsentDescription;
  final String cookieConsentAccept;
  final String cookieConsentCustomize;
  final String cookieConsentDecline;
  final String cookieConsentSave;
  final String cookieConsentNecessaryTitle;
  final String cookieConsentAnalyticsTitle;
  final String cookieConsentPreferencesTitle;

  // Official Banner
  final String officialBannerTitle;
  final String officialBannerSubtitle;

  // Drawer
  final String drawerHeaderTitle;
  final String drawerHeaderSubtitle;
  final String drawerFooterText;
  final String drawerLogout;

  static const MeayarLocalizations arabic = MeayarLocalizations(
    locale: Locale('ar'),
    tableEmptyMessage: 'لا توجد بيانات متاحة',
    paginationPrevious: 'السابق',
    paginationNext: 'التالي',
    dialogConfirm: 'تأكيد',
    dialogCancel: 'إلغاء',
    selectPlaceholder: 'اختر من القائمة...',
    datePickerSelectDateGregorian: 'اختيار التاريخ (ميلادي)',
    datePickerSelectDateHijri: 'اختيار التاريخ (هجري)',
    datePickerPlaceholder: 'اختر التاريخ...',
    fileUploadDropzoneTitle: 'انقر لاختيار الملفات أو السحب والإفلات هنا',
    fileUploadDefaultHint: 'ملفات PDF أو صور JPG/PNG بحد أقصى 10 ميغابايت',
    fileUploadFailed: 'فشل الرفع',
    cardStartService: 'ابدأ الخدمة',
    cardViewDetails: 'تفاصيل الخدمة',
    cookieConsentTitle: 'إشعار الخصوصية وملفات تعريف الارتباط',
    cookieConsentDescription: 'تستخدم بوابة معيار للخدمات الحكومية ملفات تعريف الارتباط الأساسية لضمان أمان الجلسات وتقديم الخدمات الرقمية الموثوقة وفق معايير الخصوصية الوطنية.',
    cookieConsentAccept: 'قبول الكل',
    cookieConsentCustomize: 'تخصيص الإعدادات',
    cookieConsentDecline: 'الضرورية فقط',
    cookieConsentSave: 'حفظ التفضيلات',
    cookieConsentNecessaryTitle: 'ملفات تعريف الارتباط الضرورية',
    cookieConsentAnalyticsTitle: 'ملفات تعريف الارتباط التحليلية والإحصائية',
    cookieConsentPreferencesTitle: 'ملفات تعريف الارتباط لتخصيص تجربة المستخدم',
    officialBannerTitle: 'الجمهورية العربية السورية',
    officialBannerSubtitle: 'بوابة الخدمات الرقمية الموحدة',
    drawerHeaderTitle: 'بوابة الخدمات الحكومية',
    drawerHeaderSubtitle: 'الجمهورية العربية السورية',
    drawerFooterText: 'معيار • الهوية الرقمية السورية',
    drawerLogout: 'تسجيل الخروج',
  );

  static const MeayarLocalizations english = MeayarLocalizations(
    locale: Locale('en'),
    tableEmptyMessage: 'No data available',
    paginationPrevious: 'Previous',
    paginationNext: 'Next',
    dialogConfirm: 'Confirm',
    dialogCancel: 'Cancel',
    selectPlaceholder: 'Select from list...',
    datePickerSelectDateGregorian: 'Select Date (Gregorian)',
    datePickerSelectDateHijri: 'Select Date (Hijri)',
    datePickerPlaceholder: 'Select date...',
    fileUploadDropzoneTitle: 'Click to select files or drag and drop here',
    fileUploadDefaultHint: 'PDF or JPG/PNG files up to 10 MB',
    fileUploadFailed: 'Upload failed',
    cardStartService: 'Start Service',
    cardViewDetails: 'Service Details',
    cookieConsentTitle: 'Privacy & Cookies Notice',
    cookieConsentDescription: 'Meayar Government Services portal uses essential cookies to ensure session security and deliver trusted digital services in accordance with national privacy standards.',
    cookieConsentAccept: 'Accept All',
    cookieConsentCustomize: 'Customize Settings',
    cookieConsentDecline: 'Essential Only',
    cookieConsentSave: 'Save Preferences',
    cookieConsentNecessaryTitle: 'Strictly Necessary Cookies',
    cookieConsentAnalyticsTitle: 'Analytics & Performance Cookies',
    cookieConsentPreferencesTitle: 'Personalization & Experience Cookies',
    officialBannerTitle: 'Syrian Arab Republic',
    officialBannerSubtitle: 'Unified Digital Services Portal',
    drawerHeaderTitle: 'Government Services Portal',
    drawerHeaderSubtitle: 'Syrian Arab Republic',
    drawerFooterText: 'Meayar • Syrian Digital Identity',
    drawerLogout: 'Log out',
  );

  static const LocalizationsDelegate<MeayarLocalizations> delegate = _MeayarLocalizationsDelegate();

  /// Resolves the current localizations from [BuildContext].
  /// If not provided via [Localizations.of], automatically resolves
  /// based on ambient [Locale] (English if en, Arabic otherwise).
  static MeayarLocalizations of(BuildContext context) {
    final localized = Localizations.of<MeayarLocalizations>(context, MeayarLocalizations);
    if (localized != null) return localized;

    final ambientLocale = Localizations.maybeLocaleOf(context) ??
        View.maybeOf(context)?.platformDispatcher.locale ??
        WidgetsBinding.instance.platformDispatcher.locale;

    if (ambientLocale.languageCode == 'en') {
      return english;
    }
    return arabic;
  }
}

class _MeayarLocalizationsDelegate extends LocalizationsDelegate<MeayarLocalizations> {
  const _MeayarLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<MeayarLocalizations> load(Locale locale) {
    if (locale.languageCode == 'en') {
      return SynchronousFuture<MeayarLocalizations>(MeayarLocalizations.english);
    }
    return SynchronousFuture<MeayarLocalizations>(MeayarLocalizations.arabic);
  }

  @override
  bool shouldReload(_MeayarLocalizationsDelegate old) => false;
}
