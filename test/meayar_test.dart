import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meayar_flutter/meayar.dart';

void main() {
  group('Meayar Foundations & Themes', () {
    test('Light and Dark color tokens match Syrian visual identity', () {
      final light = MeayarColors.light;
      expect(light.backgroundBrand, const Color(0xFF094239)); // Pine Green
      expect(light.isDark, isFalse);

      final dark = MeayarColors.dark;
      expect(dark.backgroundBrand, const Color(0xFF3B877B));
      expect(dark.isDark, isTrue);
    });

    test('Material 3 theme generation inherits Syrian tokens', () {
      final theme = MeayarTheme.createThemeData(brightness: Brightness.light);
      expect(theme.colorScheme.primary, const Color(0xFF094239));
      expect(theme.useMaterial3, isTrue);
      expect(theme.extension<MeayarThemeData>(), isNotNull);
    });

    test('MeayarTypography defaults to Qomra font family', () {
      const typography = MeayarTypography();
      expect(typography.fontFamily, 'packages/meayar_flutter/Qomra');
      expect(typography.headingXl.fontFamily, 'packages/meayar_flutter/Qomra');
      expect(typography.textMd.fontFamily, 'packages/meayar_flutter/Qomra');
    });
  });

  group('Hijri Date & Calendar Utilities', () {
    test('Hijri calculation correctly converts dates', () {
      final gDate = DateTime(2026, 11, 19);
      final hDate = HijriDate.fromGregorian(gDate);

      // Verify year is around 1448 AH
      expect(hDate.hYear, greaterThanOrEqualTo(1447));
      expect(hDate.hMonth, inInclusiveRange(1, 12));
      expect(hDate.hDay, inInclusiveRange(1, 30));

      final convertedBack = hDate.toGregorian();
      expect(convertedBack.year, 2026);
      expect(convertedBack.month, 11);
      expect(convertedBack.day, inInclusiveRange(18, 20)); // Astronomical +/-1 day tolerance
    });

    test('Hijri month names match Arabic standards', () {
      final h = HijriDate(hYear: 1448, hMonth: 9, hDay: 1);
      expect(h.monthNameArabic, 'رمضان');
    });
  });

  group('Meayar Core Widgets', () {
    testWidgets('MeayarButton renders and triggers click', (tester) async {
      bool clicked = false;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          theme: MeayarTheme.createThemeData(),
          home: Scaffold(
            body: MeayarButton(
              text: 'اضغط هنا',
              onPressed: () => clicked = true,
            ),
          ),
        ),
      );

      expect(find.text('اضغط هنا'), findsOneWidget);
      await tester.tap(find.text('اضغط هنا'));
      expect(clicked, isTrue);
    });

    testWidgets('MeayarTextField handles input and label', (tester) async {
      String value = '';

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          theme: MeayarTheme.createThemeData(),
          home: Scaffold(
            body: MeayarTextField(
              label: 'اسم المستخدم',
              placeholder: 'أدخل الاسم',
              onChanged: (v) => value = v,
            ),
          ),
        ),
      );

      expect(find.text('اسم المستخدم'), findsOneWidget);
      expect(find.text('أدخل الاسم'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'طارق');
      expect(value, 'طارق');
    });

    testWidgets('MeayarControls toggle properly', (tester) async {
      bool checked = false;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          theme: MeayarTheme.createThemeData(),
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return MeayarCheckbox(
                  value: checked,
                  label: 'الموافقة',
                  onChanged: (val) => setState(() => checked = val),
                );
              },
            ),
          ),
        ),
      );

      expect(find.text('الموافقة'), findsOneWidget);
      await tester.tap(find.text('الموافقة'));
      expect(checked, isTrue);
    });

    testWidgets('MeayarOfficialBanner pumps without errors in dark mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: MeayarTheme.createThemeData(brightness: Brightness.dark),
          home: MeayarTheme(
            data: MeayarThemeData.dark,
            child: const Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: MeayarOfficialBanner(),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(MeayarOfficialBanner), findsOneWidget);
      expect(find.text('الجمهورية العربية السورية • بوابة الخدمات الرقمية الموحدة'), findsOneWidget);
    });
    testWidgets('MeayarCalendar switches between Month and Year pickers', (tester) async {
      DateTime selected = DateTime(2026, 11, 20);

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          theme: MeayarTheme.createThemeData(),
          home: MeayarTheme(
            data: MeayarThemeData.light,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: MeayarCalendar(
                  selectedDate: selected,
                  locale: const Locale('ar', 'SY'),
                  onDateSelected: (d) => selected = d,
                ),
              ),
            ),
          ),
        ),
      );

      // Verify Month and Year pills exist in header (using Syrian Arabic month formatting)
      expect(find.text('تشرين الثاني'), findsOneWidget);
      expect(find.text('2026'), findsOneWidget);

      // Tap Month pill to open Month picker (12 months)
      await tester.tap(find.text('تشرين الثاني'));
      await tester.pumpAndSettle();
      expect(find.text('كانون الثاني'), findsOneWidget);
      expect(find.text('أيار'), findsOneWidget);

      // Tap a month (e.g. نيسان - April)
      await tester.tap(find.text('نيسان'));
      await tester.pumpAndSettle();
      expect(find.text('نيسان'), findsOneWidget);

      // Tap Year pill to open Year picker
      await tester.tap(find.text('2026'));
      await tester.pumpAndSettle();

      expect(find.text('2026'), findsWidgets);

      // Tap on the year in grid to select it and return to days view
      await tester.tap(find.text('2026').last);
      await tester.pumpAndSettle();
      expect(find.text('2026'), findsOneWidget);
    });

    testWidgets('MeayarCalendar selecting year 2032 updates chosen date and year', (tester) async {
      DateTime selected = DateTime(2026, 11, 20);

      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      Text('Chosen Year: ${selected.year}'),
                      MeayarCalendar(
                        selectedDate: selected,
                        onDateSelected: (d) => setState(() => selected = d),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Chosen Year: 2026'), findsOneWidget);

      // Open year picker
      await tester.tap(find.text('2026'));
      await tester.pumpAndSettle();

      // Tap year 2032
      await tester.tap(find.text('2032'));
      await tester.pumpAndSettle();

      // The chosen date and selected year must be 2032!
      expect(find.text('Chosen Year: 2032'), findsOneWidget);
      expect(selected.year, 2032);
      expect(selected.month, 11);
      expect(selected.day, 20);
    });

    testWidgets('MeayarAccessibilityToolbar renders enlarged buttons', (tester) async {
      bool highContrast = false;

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('ar'),
          theme: MeayarTheme.createThemeData(),
          home: MeayarTheme(
            data: MeayarThemeData.light,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: StatefulBuilder(
                  builder: (context, setState) => MeayarAccessibilityToolbar(
                    onFontScaleDecrease: () {},
                    onFontScaleReset: () {},
                    onFontScaleIncrease: () {},
                    isHighContrast: highContrast,
                    onToggleHighContrast: (v) => setState(() => highContrast = v),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('A-'), findsOneWidget);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('A+'), findsOneWidget);
      expect(find.text('تباين عالٍ'), findsOneWidget);

      // Tap high contrast toggle
      await tester.tap(find.text('تباين عالٍ'));
      await tester.pumpAndSettle();
      expect(highContrast, isTrue);
    });

    testWidgets('MeayarEmptyState error type renders with textError color', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: const MaterialApp(
            home: Scaffold(
              body: MeayarEmptyState(
                type: MeayarEmptyStateType.error,
                title: 'فشل في تحميل البيانات',
                description: 'حدث خطأ أثناء الاتصال',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final iconFinder = find.byIcon(MeayarIcons.warning);
      expect(iconFinder, findsOneWidget);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.color, equals(MeayarThemeData.light.colors.textError));
    });

    testWidgets('MeayarTopAppBar and MeayarDrawerContent respect useSafeArea and preview styling', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  const MeayarTopAppBar(
                    title: 'بوابة المعاملات',
                    useSafeArea: false,
                    showBottomBorder: false,
                  ),
                  SizedBox(
                    height: 500.0,
                    child: MeayarDrawerContent(
                      useSafeArea: false,
                      width: double.infinity,
                      items: const [
                        MeayarDrawerItemData(id: 'home', title: 'الرئيسية', icon: MeayarIcons.home),
                      ],
                      onItemSelected: (_) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('بوابة المعاملات'), findsOneWidget);
      expect(find.text('الرئيسية'), findsOneWidget);
    });

    testWidgets('MeayarCalendar follows locale and accepts explicit custom locale', (tester) async {
      DateTime date = DateTime(2026, 11, 20);

      // 1. Explicit English locale
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            locale: const Locale('ar'), // ambient is Arabic
            home: Scaffold(
              body: MeayarCalendar(
                selectedDate: date,
                locale: const Locale('en'), // explicit override to English
                onDateSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Month should be November
      expect(find.text('November'), findsOneWidget);
      expect(find.text('2026'), findsOneWidget);
      // Weekdays should be English abbreviations (S, M, T, W, etc.)
      expect(find.text('M'), findsOneWidget);
      expect(find.text('W'), findsOneWidget);
      expect(find.text('F'), findsOneWidget);

      // 2. Explicit Arabic Syrian locale (ar_SY) -> تشرين الثاني
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: MeayarCalendar(
                selectedDate: date,
                locale: const Locale('ar', 'SY'),
                onDateSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('تشرين الثاني'), findsOneWidget);
      expect(find.text('س'), findsOneWidget);
      expect(find.text('ح'), findsOneWidget);
      expect(find.text('ج'), findsOneWidget);

      // 3. Explicit Arabic Egypt locale (ar_EG) -> نوفمبر
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: MeayarCalendar(
                selectedDate: date,
                locale: const Locale('ar', 'EG'),
                onDateSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('نوفمبر'), findsOneWidget);

      // 4. Explicit English Egypt locale (en_EG) -> November
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: MeayarCalendar(
                selectedDate: date,
                locale: const Locale('en', 'EG'),
                onDateSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('November'), findsOneWidget);
      expect(find.text('M'), findsOneWidget);

      // 5. Explicit French locale (fr) -> novembre (dynamically from calendar)
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: MeayarCalendar(
                selectedDate: date,
                locale: const Locale('fr'),
                onDateSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('novembre'), findsOneWidget);

      // 6. Hijri calendar with English locale
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            locale: const Locale('en'),
            home: Scaffold(
              body: MeayarCalendar(
                selectedDate: date,
                calendarType: MeayarCalendarType.hijri,
                onDateSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final h = HijriDate.fromGregorian(date);
      expect(find.text(h.monthNameEnglish), findsOneWidget);
    });

    testWidgets('MeayarCalendar header does not overflow with long month names on narrow screens', (tester) async {
      // Set a constrained narrow surface size (e.g. 300x600)
      tester.view.physicalSize = const Size(300, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      // Hijri month 6 = Jumada al-Akhirah (long name: 17 characters)
      final hijriDate = HijriDate(hYear: 1448, hMonth: 6, hDay: 4).toGregorian();

      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 280, // strictly constrained width inside a card
                  child: MeayarCalendar(
                    selectedDate: hijriDate,
                    calendarType: MeayarCalendarType.hijri,
                    locale: const Locale('en'),
                    onDateSelected: (_) {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // No RenderFlex overflow exception thrown
      expect(tester.takeException(), isNull);
      expect(find.text('1448'), findsOneWidget);
    });

    testWidgets('MeayarDatePicker formats both Gregorian and Hijri dates as YYYY/MM/DD', (tester) async {
      final date = DateTime(2026, 11, 22);
      final hijri = HijriDate.fromGregorian(date);

      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  MeayarDatePicker(
                    selectedDate: date,
                    calendarType: MeayarCalendarType.gregorian,
                    onDateSelected: (_) {},
                  ),
                  MeayarDatePicker(
                    selectedDate: date,
                    calendarType: MeayarCalendarType.hijri,
                    onDateSelected: (_) {},
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Gregorian format
      expect(find.text('2026/11/22'), findsOneWidget);
      // Hijri format
      final expectedHijri = '${hijri.hYear}/${hijri.hMonth.toString().padLeft(2, '0')}/${hijri.hDay.toString().padLeft(2, '0')}';
      expect(find.text(expectedHijri), findsOneWidget);
    });

    testWidgets('MeayarDatePicker dialog retains Arabic defaults under English ambient locale', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            locale: const Locale('en'),
            home: Scaffold(
              body: MeayarDatePicker(
                selectedDate: null,
                onDateSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Check placeholder is in Arabic
      expect(find.text('اختر التاريخ...'), findsOneWidget);

      // Tap to open dialog
      await tester.tap(find.text('اختر التاريخ...'));
      await tester.pumpAndSettle();

      // Assert Arabic title, confirm and cancel buttons are shown
      expect(find.text('اختيار التاريخ'), findsOneWidget);
      expect(find.text('تأكيد'), findsOneWidget);
      expect(find.text('إلغاء'), findsOneWidget);
    });

    test('Theme value equality and hashCode check', () {
      const theme1 = MeayarThemeData.light;
      final theme2 = MeayarThemeData.light.copyWith();
      expect(theme1, equals(theme2));
      expect(theme1.hashCode, equals(theme2.hashCode));

      const colors1 = MeayarColors.light;
      const colors2 = MeayarColors.light;
      expect(colors1, equals(colors2));
      expect(colors1.hashCode, equals(colors2.hashCode));
      expect(colors1, isNot(equals(MeayarColors.dark)));

      const shapes1 = MeayarShapes();
      const shapes2 = MeayarShapes();
      expect(shapes1, equals(shapes2));
      expect(shapes1.hashCode, equals(shapes2.hashCode));

      const typo1 = MeayarTypography();
      const typo2 = MeayarTypography();
      expect(typo1, equals(typo2));
      expect(typo1.hashCode, equals(typo2.hashCode));
    });

    testWidgets('MeayarTable renders without flex crash', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: MeayarTable<String>(
                columns: [
                  MeayarColumn<String>(
                    title: 'Col 1',
                    cellBuilder: (item) => Text(item),
                  ),
                  MeayarColumn<String>(
                    title: 'Col 2',
                    cellBuilder: (item) => Text('$item-2'),
                  ),
                ],
                items: const ['Item 1', 'Item 2'],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('Col 1'), findsOneWidget);
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('MeayarAvatarGroup renders avatars without negative padding assertion', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: const MaterialApp(
            home: Scaffold(
              body: MeayarAvatarGroup(
                avatars: [
                  MeayarAvatar(name: 'A'),
                  MeayarAvatar(name: 'B'),
                  MeayarAvatar(name: 'C'),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
    });

    testWidgets('MeayarStatCard triggers onTap callback when clicked', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: MeayarStatCard(
                title: 'Revenue',
                value: '\$10,000',
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Revenue'));
      expect(tapped, isTrue);
    });

    testWidgets('MeayarTopAppBar renders bottom widget and passes elevation', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: const MaterialApp(
            home: Scaffold(
              body: MeayarTopAppBar(
                title: 'Title',
                elevation: 4.0,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(40.0),
                  child: Text('Subheader Tab'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Subheader Tab'), findsOneWidget);
    });

    test('MeayarLocalizations provides English and Arabic strings', () {
      final ar = MeayarLocalizations.arabic;
      final en = MeayarLocalizations.english;

      expect(ar.tableEmptyMessage, 'لا توجد بيانات متاحة');
      expect(en.tableEmptyMessage, 'No data available');

      expect(ar.paginationPrevious, 'السابق');
      expect(en.paginationPrevious, 'Previous');

      expect(ar.paginationNext, 'التالي');
      expect(en.paginationNext, 'Next');

      expect(ar.selectPlaceholder, 'اختر من القائمة...');
      expect(en.selectPlaceholder, 'Select from list...');

      expect(ar.dialogConfirm, 'تأكيد');
      expect(en.dialogConfirm, 'Confirm');
    });

    testWidgets('MeayarTable supports lazy column virtualization with sticky header', (tester) async {
      final items = List.generate(50, (i) => 'Row $i');

      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            home: Scaffold(
              body: MeayarTable<String>(
                maxHeight: 200.0,
                isLazy: true,
                columns: [
                  MeayarColumn<String>(
                    title: 'Header Column',
                    cellBuilder: (item) => Text(item),
                  ),
                ],
                items: items,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Header is visible
      expect(find.text('Header Column'), findsOneWidget);
      // ListView builder is used
      expect(find.byType(ListView), findsOneWidget);
      // First items are built
      expect(find.text('Row 0'), findsOneWidget);
      // Items far down the list are not instantiated yet (virtualized)
      expect(find.text('Row 49'), findsNothing);
    });

    testWidgets('MeayarTable empty message adapts to ambient locale', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: const MaterialApp(
            locale: Locale('en'),
            home: Scaffold(
              body: MeayarTable<String>(
                columns: [
                  MeayarColumn<String>(
                    title: 'Title',
                    cellBuilder: Text.new,
                  ),
                ],
                items: [],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('No data available'), findsOneWidget);
    });

    testWidgets('MeayarPagination labels adapt to ambient English locale', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: const MaterialApp(
            locale: Locale('en'),
            home: Scaffold(
              body: MeayarPagination(
                currentPage: 2,
                totalPages: 5,
                showLabels: true,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Previous'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('MeayarSelect placeholder adapts to ambient English locale', (tester) async {
      await tester.pumpWidget(
        MeayarTheme(
          data: MeayarThemeData.light,
          child: MaterialApp(
            locale: const Locale('en'),
            home: Scaffold(
              body: MeayarSelect<String>(
                items: const ['A', 'B'],
                selectedItem: null,
                itemLabel: (s) => s,
                onItemSelected: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Select from list...'), findsOneWidget);
    });
  });
}
