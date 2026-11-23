import 'package:flutter/material.dart';
import 'package:meayar_flutter/meayar.dart';

/// Interactive Component Catalog for MEAYAR Flutter Design System.
/// Complete implementation of all 36 Syrian visual identity components.
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
    this.onOpenDrawer,
  });

  final VoidCallback? onOpenDrawer;

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // State for interactive demos
  String _inputDefault = '';
  String _inputPhone = '0933123456';
  String _inputTextarea = '';
  DateTime? _selectedDateMillis;
  DateTime? _selectedHijriDateMillis;
  String _inputError = 'wrong-input';
  int _tabIndexLine = 0;
  int _tabIndexPill = 1;

  // Button Loading & Group State
  bool _buttonLoading = false;
  int _selectedButtonGroupIndex = 0;

  // Cookie Consent State
  bool _showCookieConsentDemo = true;

  // Controls State
  bool _checkboxState1 = true;
  bool _checkboxState2 = false;
  int _selectedRadio = 0;
  bool _switchState1 = true;

  // Select Dropdown State
  final List<String> _governorates = [
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
  ];
  String? _selectedGovernorate = 'دمشق';

  // OTP State
  String _otpCode = '4821';

  // Rating & Slider State
  int _userRating = 4;
  double _sliderValue = 0.7;

  // Stepper & Pagination State
  int _currentStepperIndex = 1;
  int _currentPageNumber = 2;

  // Progress State
  final double _progressVal = 0.65;

  // File Upload State
  List<MeayarFileItem> _uploadedFiles = [
    const MeayarFileItem(
      id: '1',
      name: 'البطاقة_الشخصية_الوجه_الأول.pdf',
      sizeString: '2.4 MB',
      progress: 1.0,
    ),
    const MeayarFileItem(
      id: '2',
      name: 'سند_إقامة_معتمد.jpg',
      sizeString: '1.1 MB',
      progress: 0.65,
    ),
  ];

  // Calendar State
  DateTime _calSelectedDate = DateTime(2026, 11, 15);
  int _selectedCalendarTypeIndex = 0;

  // Accessibility Toolbar State
  bool _isHighContrastDemo = false;

  // Drawer Selected Item State
  String _selectedDrawerItem = 'services';

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    final drawerNavItems = [
      MeayarDrawerItemData(
        id: 'home',
        title: 'الرئيسية',
        icon: MeayarIcons.home,
        isSelected: _selectedDrawerItem == 'home',
      ),
      MeayarDrawerItemData(
        id: 'services',
        title: 'دليل المعاملات',
        icon: MeayarIcons.document,
        badge: '12 خدمة',
        isSelected: _selectedDrawerItem == 'services',
      ),
      MeayarDrawerItemData(
        id: 'calendar',
        title: 'مواعيدي',
        icon: MeayarIcons.calendar,
        badge: 'موعد جديد',
        isSelected: _selectedDrawerItem == 'calendar',
      ),
      MeayarDrawerItemData(
        id: 'settings',
        title: 'إعدادات الحساب',
        icon: MeayarIcons.user,
        isSelected: _selectedDrawerItem == 'settings',
      ),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 96.0),
      children: [
          // Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'معرض مكوّنات معيار الشامل',
                style: typography.headingMd.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: 4.0),
              Text(
                'المكتبة الكاملة لجميع مكوّنات الهوية الرقمية السورية (MEAYAR Flutter) مع التوافق التام للغة العربية والوضع الداكن.',
                style: typography.textSm.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // 0. Official Headers & App Bars
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الترويسات والأشرطة العُلوية الرسمية (Official Headers & App Bars)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'الشريط الحكومي الموحد (Official Banner):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colors.borderSubtle, width: 1.0),
                  ),
                  child: const MeayarOfficialBanner(),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'شريط التطبيق العُلوي (Top App Bar):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: colors.borderSubtle, width: 1.0),
                  ),
                  child: MeayarTopAppBar(
                    useSafeArea: false,
                    showBottomBorder: false,
                    title: 'بوابة المعاملات الحكومية',
                    onNavigationClick: widget.onOpenDrawer,
                    leading: IconButton(
                      icon: const Icon(MeayarIcons.menu),
                      onPressed: widget.onOpenDrawer,
                      tooltip: 'القائمة الجانبية',
                      color: colors.iconPrimary,
                    ),
                    actions: [
                      MeayarIconButton(
                        onPressed: () {},
                        icon: const Icon(MeayarIcons.search, size: 20.0),
                      ),
                      MeayarIconButton(
                        onPressed: () {},
                        icon: const Icon(MeayarIcons.helpOutline, size: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 1. Breadcrumbs
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مسار التصفح (Breadcrumbs):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarBreadcrumbs(
                  items: const ['الرئيسية', 'الخدمات الإلكترونية', 'وزارة الصحة', 'حجز موعد'],
                  onItemClick: (_) {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 2. Tabs Section (Line & Pill)
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'التبويبات (Tabs)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'نمط الخط (Line):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarTabs(
                  tabs: const ['نظرة عامة', 'الطلبات الحالية', 'الأرشيف'],
                  selectedIndex: _tabIndexLine,
                  onTabSelected: (idx) => setState(() => _tabIndexLine = idx),
                  style: MeayarTabStyle.line,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'نمط الكبسولة (Pill):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarTabs(
                  tabs: const ['يومي', 'أسبوعي', 'شهري', 'سنوي'],
                  selectedIndex: _tabIndexPill,
                  onTabSelected: (idx) => setState(() => _tabIndexPill = idx),
                  style: MeayarTabStyle.pill,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 3. Tags & Badges Section (All 7 colors and 3 hierarchies)
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الشارات والتصنيفات (Tags & Badges)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'الألوان الرسمية السبعة (Secondary):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: const [
                    MeayarTag(text: 'أخضر سوري (Primary)', color: MeayarTagColor.primary),
                    MeayarTag(text: 'مكتمل (Green)', color: MeayarTagColor.green),
                    MeayarTag(text: 'عاجل (Red)', color: MeayarTagColor.red),
                    MeayarTag(text: 'قيد المعالجة (Yellow)', color: MeayarTagColor.yellow),
                    MeayarTag(text: 'مميّز (Gold)', color: MeayarTagColor.gold),
                    MeayarTag(text: 'معلومات (Blue)', color: MeayarTagColor.blue),
                    MeayarTag(text: 'مسودة (Gray)', color: MeayarTagColor.gray),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  'مستويات الظهور (Filled, Secondary, Outlined):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: const [
                    MeayarTag(text: 'ممتلئ Filled', color: MeayarTagColor.primary, hierarchy: MeayarTagHierarchy.filled),
                    SizedBox(width: 8.0),
                    MeayarTag(text: 'ثانوي Secondary', color: MeayarTagColor.primary, hierarchy: MeayarTagHierarchy.secondary),
                    SizedBox(width: 8.0),
                    MeayarTag(text: 'محدد Outlined', color: MeayarTagColor.primary, hierarchy: MeayarTagHierarchy.outlined),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 4. Buttons & Icon-Only Buttons
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الأزرار وأزرار الأيقونات (Buttons & Icon Buttons)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'الأنماط (Hierarchy):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    MeayarButton(
                      text: 'رئيسي Primary',
                      onPressed: () {},
                      variant: MeayarButtonVariant.primary,
                    ),
                    MeayarButton(
                      text: 'ثانوي Secondary',
                      onPressed: () {},
                      variant: MeayarButtonVariant.secondary,
                    ),
                    MeayarButton(
                      text: 'محدد Outlined',
                      onPressed: () {},
                      variant: MeayarButtonVariant.outlined,
                    ),
                    MeayarButton(
                      text: 'شفاف Ghost',
                      onPressed: () {},
                      variant: MeayarButtonVariant.ghost,
                    ),
                    MeayarButton(
                      text: 'تحذيري Destructive',
                      onPressed: () {},
                      variant: MeayarButtonVariant.destructive,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  'الأحجام (XL..XS):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MeayarButton(text: 'XL 60', size: MeayarButtonSize.xl, onPressed: () {}),
                      const SizedBox(width: 8.0),
                      MeayarButton(text: 'LG 48', size: MeayarButtonSize.lg, onPressed: () {}),
                      const SizedBox(width: 8.0),
                      MeayarButton(text: 'MD 44', size: MeayarButtonSize.md, onPressed: () {}),
                      const SizedBox(width: 8.0),
                      MeayarButton(text: 'SM 32', size: MeayarButtonSize.sm, onPressed: () {}),
                      const SizedBox(width: 8.0),
                      MeayarButton(text: 'XS', size: MeayarButtonSize.xs, onPressed: () {}),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'أزرار الأيقونات فقط (Icon Only):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MeayarIconButton(
                        onPressed: () {},
                        size: MeayarButtonSize.xl,
                        variant: MeayarButtonVariant.primary,
                        icon: const Icon(MeayarIcons.search),
                      ),
                      const SizedBox(width: 8.0),
                      MeayarIconButton(
                        onPressed: () {},
                        size: MeayarButtonSize.lg,
                        variant: MeayarButtonVariant.secondary,
                        icon: const Icon(MeayarIcons.add),
                      ),
                      const SizedBox(width: 8.0),
                      MeayarIconButton(
                        onPressed: () {},
                        size: MeayarButtonSize.md,
                        variant: MeayarButtonVariant.outlined,
                        icon: const Icon(MeayarIcons.check),
                      ),
                      const SizedBox(width: 8.0),
                      MeayarIconButton(
                        onPressed: () {},
                        size: MeayarButtonSize.sm,
                        variant: MeayarButtonVariant.ghost,
                        icon: const Icon(MeayarIcons.close),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    MeayarButton(
                      text: 'انقر لتفعيل التحميل',
                      loading: _buttonLoading,
                      onPressed: () {
                        setState(() => _buttonLoading = true);
                        Future.delayed(const Duration(seconds: 2), () {
                          if (mounted) setState(() => _buttonLoading = false);
                        });
                      },
                      variant: MeayarButtonVariant.primary,
                      leading: const Icon(MeayarIcons.add),
                    ),
                    const SizedBox(width: 8.0),
                    const MeayarButton(
                      text: 'معطل (Disabled)',
                      enabled: false,
                      onPressed: null,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 4b. Button Groups
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مجموعات الأزرار المتصلة (Button Groups)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'أزرار مجمعة متصلة للحالات المتعددة والتنقل السريع مع حواف خارجية منحنية تلقائياً حسب اتجاه النص العربي/الإنجليزي:',
                  style: typography.textSm.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'مجموعة خيارات أحادية (Single Selection - SegmentedButton):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarSegmentedButton(
                  items: const [
                    MeayarButtonGroupItem(title: 'يومي', leading: Icon(MeayarIcons.calendar, size: 16.0)),
                    MeayarButtonGroupItem(title: 'أسبوعي', leading: Icon(MeayarIcons.clock, size: 16.0)),
                    MeayarButtonGroupItem(title: 'شهري', leading: Icon(MeayarIcons.document, size: 16.0)),
                  ],
                  selectedIndex: _selectedButtonGroupIndex,
                  onItemSelected: (idx) => setState(() => _selectedButtonGroupIndex = idx),
                  size: MeayarButtonSize.md,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'مجموعة إجراءات مستقلة (Actions):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarButtonGroup(
                  items: const [
                    MeayarButtonGroupItem(title: 'معاينة', leading: Icon(MeayarIcons.search, size: 16.0)),
                    MeayarButtonGroupItem(title: 'تحميل', leading: Icon(MeayarIcons.upload, size: 16.0)),
                    MeayarButtonGroupItem(title: 'مشاركة', leading: Icon(MeayarIcons.arrowForward, size: 16.0)),
                  ],
                  onItemSelected: (_) {},
                  size: MeayarButtonSize.sm,
                  variant: MeayarButtonVariant.secondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 5. Inputs & Textarea Section
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'حقول الإدخال ومربعات النصوص (Inputs & Textarea)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarTextField(
                  label: 'الاسم الكامل',
                  isMandatory: true,
                  placeholder: 'أدخل اسمك الثلاثي كما في الهوية...',
                  helperText: 'يجب أن يتطابق الاسم مع قيود السجل المدني',
                  leading: const Icon(MeayarIcons.user),
                  initialValue: _inputDefault,
                  onChanged: (v) => _inputDefault = v,
                ),
                const SizedBox(height: 16.0),
                MeayarTextField(
                  label: 'رقم الهاتف المحمول (LTR في نموذج RTL)',
                  isMandatory: true,
                  forceLtrContent: true,
                  placeholder: '+963 9xxxxxxxx',
                  helperText: 'يتم الحفاظ على اتجاه الأرقام من اليسار لليمين',
                  leading: const Icon(MeayarIcons.phone),
                  initialValue: _inputPhone,
                  onChanged: (v) => _inputPhone = v,
                ),
                const SizedBox(height: 16.0),
                MeayarTextField(
                  label: 'الملاحظات الإضافية (Textarea / Multiline)',
                  placeholder: 'اكتب تفاصيل المعاملة هنا...',
                  minLines: 3,
                  maxLines: null,
                  initialValue: _inputTextarea,
                  onChanged: (v) => _inputTextarea = v,
                ),
                const SizedBox(height: 16.0),
                MeayarDatePicker(
                  locale: const Locale('ar', 'SY'),
                  selectedDate: _selectedDateMillis,
                  onDateSelected: (d) => setState(() => _selectedDateMillis = d),
                  label: 'تاريخ المعاملة (ميلادي - Gregorian Date Picker)',
                  isMandatory: true,
                ),
                const SizedBox(height: 16.0),
                MeayarDatePicker(
                  locale: const Locale('ar', 'SY'),
                  selectedDate: _selectedHijriDateMillis,
                  onDateSelected: (d) => setState(() => _selectedHijriDateMillis = d),
                  label: 'تاريخ المعاملة (هجري - Hijri Date Picker)',
                  calendarType: MeayarCalendarType.hijri,
                  placeholder: 'اختر التاريخ الهجري...',
                ),
                const SizedBox(height: 16.0),
                MeayarTextField(
                  label: 'البريد الإلكتروني',
                  isError: true,
                  errorMessage: 'صيغة البريد الإلكتروني غير صالحة',
                  leading: const Icon(MeayarIcons.warning),
                  initialValue: _inputError,
                  onChanged: (v) => _inputError = v,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 6. OTP Input Section
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رمز التحقق (OTP Input)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'حقل إدخال رمز التحقق الرقمي مع محاذاة LTR واستجابة فورية للوحة المفاتيح:',
                  style: typography.textSm.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 16.0),
                Center(
                  child: MeayarOtpInput(
                    length: 4,
                    value: _otpCode,
                    onChanged: (v) => setState(() => _otpCode = v),
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'الرمز المدخل حالياً: $_otpCode',
                  style: typography.textXsMedium.copyWith(color: colors.textBrand),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 7. Stepper Section
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مؤشر الخطوات (Stepper)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarStepper(
                  steps: const [
                    MeayarStep(title: 'بيانات المتقدم'),
                    MeayarStep(title: 'حجز الموعد'),
                    MeayarStep(title: 'دفع الرسوم'),
                    MeayarStep(title: 'تأكيد الطلب'),
                  ],
                  currentStepIndex: _currentStepperIndex,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    MeayarButton(
                      text: 'الخطوة السابقة',
                      size: MeayarButtonSize.sm,
                      variant: MeayarButtonVariant.outlined,
                      onPressed: () {
                        setState(() {
                          _currentStepperIndex = (_currentStepperIndex - 1).clamp(0, 3);
                        });
                      },
                    ),
                    const SizedBox(width: 8.0),
                    MeayarButton(
                      text: 'الخطوة التالية',
                      size: MeayarButtonSize.sm,
                      variant: MeayarButtonVariant.primary,
                      onPressed: () {
                        setState(() {
                          _currentStepperIndex = (_currentStepperIndex + 1).clamp(0, 3);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 8. Service Card Demonstration
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'بطاقة الخدمة الحكومية (Service Card)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarServiceCard(
                  title: 'تجديد البطاقة الشخصية إلكترونياً',
                  description: 'خدمة للمواطنين داخل القطر لتجديد الهوية المدنية مع التوصيل إلى العنوان المعتمد.',
                  tagText: 'خدمة شائعة',
                  tagColor: MeayarTagColor.primary,
                  icon: MeayarIcons.user,
                  metaList: const [
                    MeayarServiceMeta(icon: MeayarIcons.clock, label: 'المدة', value: '5 أيام'),
                    MeayarServiceMeta(icon: MeayarIcons.document, label: 'الرسوم', value: '10,000 ل.س'),
                    MeayarServiceMeta(icon: MeayarIcons.building, label: 'القناة', value: 'إلكتروني'),
                  ],
                  onStartService: () {
                    showDialog<void>(
                      context: context,
                      builder: (dialogCtx) => MeayarDialog(
                        title: 'تجديد البطاقة الشخصية إلكترونياً',
                        description: 'يرجى تأكيد الرغبة في بدء معاملة تجديد البطاقة الشخصية. سيتم توجيهك لاستكمال المتطلبات الرسمية.',
                        confirmText: 'متابعة الطلب',
                        cancelText: 'إلغاء',
                        icon: const Icon(MeayarIcons.document, size: 24.0),
                        onConfirm: () => Navigator.of(dialogCtx).pop(),
                        onCancel: () => Navigator.of(dialogCtx).pop(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 9. Stat Cards Section
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'بطاقات الإحصائيات (Stat Cards)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                const MeayarStatCard(
                  title: 'إجمالي المعاملات الحكومية المنجزة',
                  value: '142,850',
                  description: 'محدثة حتى اليوم، مقارنة بإحصائيات الشهر الماضي',
                  delta: '+14.8%',
                  isPositiveDelta: true,
                  icon: MeayarIcons.document,
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: const [
                    Expanded(
                      child: MeayarStatCard(
                        title: 'المعاملات',
                        value: '142K',
                        delta: '+14%',
                        isPositiveDelta: true,
                        icon: MeayarIcons.document,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: MeayarStatCard(
                        title: 'قيد المعالجة',
                        value: '1,420',
                        delta: '-3.2%',
                        isPositiveDelta: false,
                        icon: MeayarIcons.clock,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 10. Select Dropdown Menu
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'القوائم المنسدلة (Select / Dropdown)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarSelect<String>(
                  items: _governorates,
                  selectedItem: _selectedGovernorate,
                  onItemSelected: (v) => setState(() => _selectedGovernorate = v),
                  itemLabel: (it) => it,
                  label: 'المحافظة',
                  isMandatory: true,
                  placeholder: 'اختر المحافظة...',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 11. Selection Controls (Checkbox, Radio, Switch)
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'عناصر الاختيار والتحكم (Form Controls)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarCheckbox(
                  value: _checkboxState1,
                  onChanged: (v) => setState(() => _checkboxState1 = v),
                  label: 'أوافق على الشروط والأحكام الرسمية',
                  description: 'يتطلب تفعيل هذا الخيار موافقة المستخدم على سياسة الخصوصية',
                ),
                const SizedBox(height: 8.0),
                MeayarCheckbox(
                  value: _checkboxState2,
                  onChanged: (v) => setState(() => _checkboxState2 = v),
                  label: 'استلام الإشعارات عبر الرسائل النصية القصيرة',
                ),
                const SizedBox(height: 12.0),
                const MeayarDivider(),
                const SizedBox(height: 12.0),
                MeayarRadio<int>(
                  value: 0,
                  groupValue: _selectedRadio,
                  onChanged: (v) => setState(() => _selectedRadio = v),
                  label: 'الدفع الإلكتروني عبر الحساب البنكي الموحد',
                  description: 'خصم مباشر من الحساب المصرفي دون رسوم إضافية',
                ),
                const SizedBox(height: 8.0),
                MeayarRadio<int>(
                  value: 1,
                  groupValue: _selectedRadio,
                  onChanged: (v) => setState(() => _selectedRadio = v),
                  label: 'الدفع نقداً عند استلام المعاملة',
                  description: 'يتطلب الحضور إلى مركز الخدمة خلال 3 أيام عمل',
                ),
                const SizedBox(height: 12.0),
                const MeayarDivider(),
                const SizedBox(height: 12.0),
                MeayarSwitch(
                  value: _switchState1,
                  onChanged: (v) => setState(() => _switchState1 = v),
                  label: 'التحقق بخطوتين (2FA)',
                  description: 'طلب رمز OTP إضافي عند تسجيل الدخول',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 12. Rating & Slider Section
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'التقييم وأشرطة التمرير (Rating & Slider)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تقييم جودة الخدمة:',
                      style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                    ),
                    MeayarRating(
                      rating: _userRating.toDouble(),
                      onRatingChanged: (r) => setState(() => _userRating = r.round()),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                const MeayarDivider(),
                const SizedBox(height: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نسبة الإنجاز المطلوبة: ${(_sliderValue * 100).toInt()}%',
                      style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: 6.0),
                    MeayarSlider(
                      value: _sliderValue,
                      onChanged: (v) => setState(() => _sliderValue = v),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 13. Dividers (Horizontal & Vertical)
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الفواصل (Dividers)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'فاصل أفقي (Horizontal Divider):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                const MeayarDivider(),
                const SizedBox(height: 16.0),
                Text(
                  'فاصل عمودي داخل شريط إجراءات (Vertical Divider):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MeayarButton(
                      text: 'تعديل',
                      size: MeayarButtonSize.sm,
                      variant: MeayarButtonVariant.ghost,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8.0),
                    const SizedBox(height: 20.0, child: MeayarVerticalDivider()),
                    const SizedBox(width: 8.0),
                    MeayarButton(
                      text: 'مشاركة',
                      size: MeayarButtonSize.sm,
                      variant: MeayarButtonVariant.ghost,
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8.0),
                    const SizedBox(height: 20.0, child: MeayarVerticalDivider()),
                    const SizedBox(width: 8.0),
                    MeayarButton(
                      text: 'طباعة',
                      size: MeayarButtonSize.sm,
                      variant: MeayarButtonVariant.ghost,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 14. Pagination Section
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ترقيم الصفحات (Pagination)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'النمط الافتراضي مع تسميات التنقل (Default with Labels):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarPagination(
                  currentPage: _currentPageNumber,
                  totalPages: 5,
                  onPageSelected: (p) => setState(() => _currentPageNumber = p),
                  showLabels: true,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'النمط المبسط بالأرقام فقط (Minimal Centered):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarPagination(
                  currentPage: _currentPageNumber,
                  totalPages: 5,
                  onPageSelected: (p) => setState(() => _currentPageNumber = p),
                  showLabels: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 14b. Document Card & Page Feedback
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المستندات الرسمية وتقييم الصفحة (Document & Feedback)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarDocumentCard(
                  title: 'المرسوم التشريعي رقم 14 الخاص بالتحول الرقمي',
                  fileType: 'PDF',
                  fileSize: '2.4 MB',
                  onDownload: () {},
                ),
                const SizedBox(height: 16.0),
                const MeayarPageFeedback(),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 15. Accordion Section
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'القوائم القابلة للطي (Accordion)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarAccordion(
                  title: 'ما هي الأوراق المطلوبة لتجديد جواز السفر؟',
                  initiallyExpanded: true,
                  content: Text(
                    'يتطلب تقديم البطاقة الشخصية الأصلية، صورتين شخصيتين ملونتين بخلفية بيضاء، ودفع الرسوم المقررة عبر المنظومة الإلكترونية.',
                    style: typography.textSm.copyWith(color: colors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 16. Indicators (Progress, Spinner & Skeleton)
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مؤشرات التحميل والتقدم (Progress, Spinner & Skeleton)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'شريط التقدم الخطي (Progress Bar):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarProgressBar(value: _progressVal),
                const SizedBox(height: 16.0),
                Text(
                  'مؤشر التحميل الدائري الرسمي (Meayar Spinner):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: const [
                    MeayarSpinner(size: MeayarSpinnerSize.xs),
                    SizedBox(width: 16.0),
                    MeayarSpinner(size: MeayarSpinnerSize.sm),
                    SizedBox(width: 16.0),
                    MeayarSpinner(size: MeayarSpinnerSize.md),
                    SizedBox(width: 16.0),
                    MeayarSpinner(size: MeayarSpinnerSize.lg),
                    SizedBox(width: 16.0),
                    MeayarSpinner(size: MeayarSpinnerSize.xl),
                  ],
                ),
                const SizedBox(height: 12.0),
                const MeayarSpinner(
                  size: MeayarSpinnerSize.sm,
                  label: 'جاري التحقق من الهوية الرقمية...',
                ),
                const SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colors.backgroundBrand,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: const MeayarSpinner(
                    size: MeayarSpinnerSize.sm,
                    label: 'نمط التحميل المعكوس (Inverse Spinner on Brand Surface)',
                    isInverse: true,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'الهيكل العظمي النابض (Skeleton Loader):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const MeayarSkeleton(width: 44.0, height: 44.0),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.7,
                            child: const MeayarSkeleton(height: 14.0),
                          ),
                          const SizedBox(height: 8.0),
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: const MeayarSkeleton(height: 10.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 17. Avatars & Badges
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الصور الرمزية والشارات (Avatars & Badges)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: const [
                    MeayarAvatar(name: 'عمر الخيام', size: MeayarAvatarSize.xl, status: MeayarPresenceStatus.online),
                    SizedBox(width: 12.0),
                    MeayarAvatar(name: 'سارة أحمد', size: MeayarAvatarSize.lg, status: MeayarPresenceStatus.busy),
                    SizedBox(width: 12.0),
                    MeayarAvatar(name: 'محمد دمشقي', size: MeayarAvatarSize.md, status: MeayarPresenceStatus.offline),
                    SizedBox(width: 12.0),
                    MeayarAvatar(name: 'نور الهدى', size: MeayarAvatarSize.sm),
                    SizedBox(width: 12.0),
                    MeayarAvatar(name: 'حلب', size: MeayarAvatarSize.xs),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      'شارات التنبيهات:',
                      style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(width: 12.0),
                    const MeayarBadge(count: 3),
                    const SizedBox(width: 8.0),
                    MeayarBadge(count: 42, containerColor: colors.backgroundBrand),
                    const SizedBox(width: 8.0),
                    const MeayarBadge(count: 150),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 18. Empty State Section
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الحالات الفارغة (Empty State)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarEmptyState(
                  title: 'لا توجد معاملات سابقة',
                  description: 'لم تقم بتقديم أي طلبات عبر المنظومة بعد. يمكنك بدء معاملة جديدة بالضغط على الزر أدناه.',
                  type: MeayarEmptyStateType.noData,
                  actionText: 'تقديم طلب جديد',
                  onActionClick: () {},
                ),
                const SizedBox(height: 12.0),
                const MeayarDivider(),
                const SizedBox(height: 12.0),
                MeayarEmptyState(
                  title: 'لا توجد نتائج مطابقة',
                  description: 'لم نتمكن من العثور على أي نتائج لكلمة البحث المدخلة. يرجى تجربة عبارات بحث بديلة.',
                  type: MeayarEmptyStateType.noResults,
                  actionText: 'مسح البحث',
                  onActionClick: () {},
                ),
                const SizedBox(height: 12.0),
                const MeayarDivider(),
                const SizedBox(height: 12.0),
                MeayarEmptyState(
                  title: 'فشل في تحميل البيانات',
                  description: 'حدث خطأ أثناء الاتصال بالخادم الحكومي. يرجى التحقق من اتصال الإنترنت والمحاولة مجدداً.',
                  type: MeayarEmptyStateType.error,
                  actionText: 'إعادة المحاولة',
                  onActionClick: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 19. Brand Alerts
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'تنبيهات معيار الرسمية',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarAlert(
                  title: 'تنبيه رئيسي (Style=Primary)',
                  description: 'تنبيه رسمي بارز بخلفية الأخضر السوري الأساسي #094239.',
                  style: MeayarAlertStyle.primary,
                  onDismiss: () {},
                ),
                const SizedBox(height: 12.0),
                MeayarAlert(
                  title: 'تنبيه ثانوي (Style=Secondary)',
                  description: 'تنبيه هادئ بخلفية الأخضر المخفف #D8DFDE.',
                  style: MeayarAlertStyle.secondary,
                  onDismiss: () {},
                ),
                const SizedBox(height: 12.0),
                MeayarAlert(
                  title: 'تنبيه محايد (Style=Neutral)',
                  description: 'تنبيه رمادي للملاحظات التنظيمية العامة.',
                  style: MeayarAlertStyle.neutral,
                  onDismiss: () {},
                ),
                const SizedBox(height: 12.0),
                MeayarAlert(
                  title: 'تنبيه بسيط (Style=Simple)',
                  description: 'تنبيه بإطار خفيف وبدون خلفية ملونة للملاحظات الخفيفة.',
                  style: MeayarAlertStyle.simple,
                  onDismiss: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 20. Semantic Toasts (Success, Error, Warning, Info)
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الإشعارات العائمة',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarToast(
                  title: 'نجاح العملية',
                  description: 'تم حفظ التغييرات وتحديث السجل الرقمي.',
                  type: MeayarToastType.success,
                  onClose: () {},
                ),
                const SizedBox(height: 12.0),
                MeayarToast(
                  title: 'تنبيه تنفيذي',
                  description: 'يرجى تسديد الرسوم خلال المهلة القانونية المحددة.',
                  type: MeayarToastType.warning,
                  onClose: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 20b. Tooltips
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'التلميحات العائمة (Tooltips)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'عناصر إرشادية سريعة توفر شروحات سياقية للحقول والرموز بتصميم معيار الداكن المتباين:',
                  style: typography.textSm.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      'فقاعة التلميح القياسية:',
                      style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(width: 8.0),
                    const Flexible(
                      child: MeayarTooltip(
                        text: 'الرقم الوطني يتألف من 11 خانة رقمية',
                        icon: MeayarIcons.info,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text(
                      'عنصر تفاعلي (انقر للإظهار):',
                      style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(width: 12.0),
                    MeayarTooltipBox(
                      tooltipText: 'رمز التحقق يرسل عبر الرسائل القصيرة SMS',
                      icon: MeayarIcons.helpOutline,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: colors.backgroundSubtle,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(MeayarIcons.helpOutline, size: 16.0, color: colors.iconBrand),
                            const SizedBox(width: 4.0),
                            Text(
                              'شرح رمز التحقق',
                              style: typography.textXsMedium.copyWith(color: colors.textBrand),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 21. Snackbars (MeayarSnackbar)
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أشرطة التنبيه المحمولة (Snackbars)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'النمط المعكوس القياسي مع زر الإجراء (Inverse with Action):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarSnackbarWidget(
                  message: 'تم أرشفة المعاملة بنجاح',
                  actionLabel: 'تراجع',
                  onActionClick: () {},
                  style: MeayarSnackbarStyle.inverse,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'نمط الهوية السورية مع زر الإغلاق (Brand Style):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarSnackbarWidget(
                  message: 'تم تقديم الطلب إلى وزارة الصحة برقم مرجعي #94821',
                  actionLabel: 'عرض التفاصيل',
                  onActionClick: () {},
                  onDismissClick: () {},
                  style: MeayarSnackbarStyle.brand,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'تجربة إظهار شريط التنبيه الفعلي في التطبيق (Interactive Triggers):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    MeayarButton(
                      text: 'شريط أخضر رسمي (Brand)',
                      size: MeayarButtonSize.sm,
                      variant: MeayarButtonVariant.primary,
                      onPressed: () {
                        MeayarSnackbar.show(
                          context,
                          message: 'تم حفظ التعديلات في السجل الرقمي السوري بنجاح',
                          actionLabel: 'عرض',
                          style: MeayarSnackbarStyle.brand,
                          icon: Icon(MeayarIcons.checkCircle, size: 20.0, color: colors.textInverse),
                        );
                      },
                    ),
                    MeayarButton(
                      text: 'شريط داكن (Inverse)',
                      size: MeayarButtonSize.sm,
                      variant: MeayarButtonVariant.secondary,
                      onPressed: () {
                        MeayarSnackbar.show(
                          context,
                          message: 'إشعار نظام: تم تحديث البيانات بنجاح',
                          actionLabel: 'حسناً',
                          style: MeayarSnackbarStyle.inverse,
                          icon: Icon(MeayarIcons.info, size: 20.0, color: colors.textInverse),
                        );
                      },
                    ),
                    MeayarButton(
                      text: 'شريط مع تراجع (Undo)',
                      size: MeayarButtonSize.sm,
                      variant: MeayarButtonVariant.outlined,
                      onPressed: () {
                        MeayarSnackbar.show(
                          context,
                          message: 'تم نقل المعاملة إلى سلة المحذوفات',
                          actionLabel: 'تراجع',
                          style: MeayarSnackbarStyle.brand,
                          onAction: () {
                            MeayarSnackbar.show(
                              context,
                              message: 'تم التراجع عن الحذف بنجاح',
                              style: MeayarSnackbarStyle.inverse,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 22. Modal Dialog Prompt
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'النوافذ المنبثقة (Modals & Dialogs)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarButton(
                  text: 'فتح نافذة التأكيد (Show Dialog)',
                  size: MeayarButtonSize.md,
                  variant: MeayarButtonVariant.primary,
                  onPressed: () {
                    MeayarDialog.show(
                      context: context,
                      title: 'تأكيد إرسال المعاملة',
                      description: 'هل أنت متأكد من رغبتك في إرسال طلب تجديد البطاقة الشخصية؟ لن تتمكن من تعديل البيانات بعد الإرسال.',
                      confirmText: 'نعم، إرسال الطلب',
                      cancelText: 'مراجعة البيانات',
                      icon: const Icon(MeayarIcons.document, size: 24.0),
                      onConfirm: () {},
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 22b. Cookie Consent & Privacy Notice
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  'شريط ملفات تعريف الارتباط والخصوصية (Cookie Consent Banner)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
              ),
              const SizedBox(height: 8.0),
              if (_showCookieConsentDemo)
                MeayarCookieConsent(
                  onAcceptAll: () => setState(() => _showCookieConsentDemo = false),
                  onCustomize: () {},
                  onDecline: () => setState(() => _showCookieConsentDemo = false),
                )
              else
                MeayarCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تم قبول إعدادات الخصوصية بنجاح',
                        style: typography.textSmMedium.copyWith(color: colors.textSuccess),
                      ),
                      MeayarButton(
                        text: 'إعادة عرض الشريط',
                        size: MeayarButtonSize.sm,
                        variant: MeayarButtonVariant.outlined,
                        onPressed: () => setState(() => _showCookieConsentDemo = true),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24.0),

          // 23. File Upload Dropzone
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رفع المرفقات والمستندات (File Upload)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarFileUpload(
                  label: 'المستندات الثبوتية المطلوبة',
                  isMandatory: true,
                  hintText: 'ملفات PDF أو صور JPG/PNG بحد أقصى 10 ميغابايت',
                  files: _uploadedFiles,
                  onSelectFiles: () {
                    setState(() {
                      _uploadedFiles = [
                        ..._uploadedFiles,
                        MeayarFileItem(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          name: 'تقرير_طبي_معتمد_${_uploadedFiles.length + 1}.pdf',
                          sizeString: '1.8 MB',
                          progress: 1.0,
                        ),
                      ];
                    });
                  },
                  onRemoveFile: (fileToRemove) {
                    setState(() {
                      _uploadedFiles = _uploadedFiles.where((f) => f.id != fileToRemove.id).toList();
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                const MeayarDivider(),
                const SizedBox(height: 16.0),
                Text(
                  'صفوف الملفات المرفقة بحالاتها المختلفة (Attached File Row States):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 12.0),
                Column(
                  children: [
                    MeayarAttachedFileRow(
                      file: const MeayarFileItem(
                        id: 'demo-success',
                        name: 'البطاقة_الشخصية_الوجه_الأمامي.pdf',
                        sizeString: '2.4 MB',
                        progress: 1.0,
                      ),
                      onRemove: () {},
                    ),
                    const SizedBox(height: 8.0),
                    MeayarAttachedFileRow(
                      file: const MeayarFileItem(
                        id: 'demo-progress',
                        name: 'صورة_سند_الإقامة.jpg',
                        sizeString: '4.1 MB',
                        progress: 0.65,
                      ),
                      onRemove: () {},
                    ),
                    const SizedBox(height: 8.0),
                    MeayarAttachedFileRow(
                      file: const MeayarFileItem(
                        id: 'demo-error',
                        name: 'مستند_غير_صالح.exe',
                        sizeString: '14.2 MB',
                        isError: true,
                        errorMessage: 'نوع الملف غير مدعوم أو تجاوز الحد المسموح (10 MB)',
                      ),
                      onRemove: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 24. Data Table
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'جداول البيانات الحكومية (Data Tables)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarTable<Map<String, dynamic>>(
                  columns: [
                    MeayarColumn<Map<String, dynamic>>(
                      title: 'رقم المعاملة',
                      width: 100.0,
                      cellBuilder: (item) => Text(
                        item['id'] as String,
                        style: typography.textXsMedium.copyWith(color: colors.textBrand),
                      ),
                    ),
                    MeayarColumn<Map<String, dynamic>>(
                      title: 'نوع الخدمة',
                      cellBuilder: (item) => Text(
                        item['service'] as String,
                        style: typography.textXsMedium.copyWith(color: colors.textPrimary),
                      ),
                    ),
                    MeayarColumn<Map<String, dynamic>>(
                      title: 'حالة الطلب',
                      width: 105.0,
                      cellBuilder: (item) => MeayarTag(
                        text: item['status'] as String,
                        color: item['color'] as MeayarTagColor,
                        hierarchy: MeayarTagHierarchy.secondary,
                        size: MeayarTagSize.small,
                      ),
                    ),
                  ],
                  items: const [
                    {'id': 'SY-94821', 'service': 'حجز موعد عيادة', 'status': 'مكتمل', 'color': MeayarTagColor.green},
                    {'id': 'SY-94819', 'service': 'شهادة صحية دولية', 'status': 'قيد التدقيق', 'color': MeayarTagColor.yellow},
                    {'id': 'SY-93402', 'service': 'تجديد بطاقة صحية', 'status': 'بانتظار الرسوم', 'color': MeayarTagColor.gold},
                    {'id': 'SY-91024', 'service': 'شكوى إدارية', 'status': 'مرفوض', 'color': MeayarTagColor.red},
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 25. Inline Calendar Grid
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'التقويم الشبكي المباشر (Inline Calendar)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarTabs(
                  tabs: const ['ميلادي (Gregorian)', 'هجري (Hijri)'],
                  selectedIndex: _selectedCalendarTypeIndex,
                  onTabSelected: (idx) {
                    setState(() {
                      _selectedCalendarTypeIndex = idx;
                    });
                  },
                  style: MeayarTabStyle.pill,
                ),
                const SizedBox(height: 12.0),
                Text(
                  _selectedCalendarTypeIndex == 0
                      ? 'تاريخ الموعد المحدد (ميلادي): ${_calSelectedDate.day}/${_calSelectedDate.month}/${_calSelectedDate.year}'
                      : 'تاريخ الموعد المحدد (هجري): ${HijriDate.fromGregorian(_calSelectedDate).format(inArabic: true)}',
                  style: typography.textSmMedium.copyWith(color: colors.textBrand),
                ),
                const SizedBox(height: 12.0),
                MeayarCalendar(
                  selectedDate: _calSelectedDate,
                  locale: const Locale('ar', 'SY'),
                  calendarType: _selectedCalendarTypeIndex == 0
                      ? MeayarCalendarType.gregorian
                      : MeayarCalendarType.hijri,
                  onDateSelected: (d) => setState(() => _calSelectedDate = d),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 26. Accessibility Toolbar
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'شريط سهولة الاستخدام (Accessibility Toolbar)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                MeayarAccessibilityToolbar(
                  onFontScaleDecrease: () {},
                  onFontScaleReset: () {},
                  onFontScaleIncrease: () {},
                  isHighContrast: _isHighContrastDemo,
                  onToggleHighContrast: (v) => setState(() => _isHighContrastDemo = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),

          // 27. Navigation Drawer & Side Nav
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'القائمة الجانبية والشريط الملاحي (Drawer & Side Nav)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'القائمة التفاعلية المنزلقة (Interactive Modal Navigation Drawer):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                MeayarButton(
                  text: 'فتح القائمة الجانبية (Open Navigation Drawer)',
                  leading: const Icon(MeayarIcons.menu, size: 18.0),
                  variant: MeayarButtonVariant.primary,
                  onPressed: widget.onOpenDrawer,
                ),
                const SizedBox(height: 16.0),
                Text(
                  'المعاينة المباشرة لمحتوى القائمة (In-Card Content Preview):',
                  style: typography.textSmMedium.copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 540.0,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: colors.borderSubtle, width: 1.0),
                    ),
                    child: MeayarDrawerContent(
                      useSafeArea: false,
                      width: double.infinity,
                      items: drawerNavItems,
                      onItemSelected: (item) => setState(() => _selectedDrawerItem = item.id),
                      userName: 'حمزة الخطيب',
                      userNationalId: '01030094821',
                      onLogoutClick: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
