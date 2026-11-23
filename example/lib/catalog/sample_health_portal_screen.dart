import 'package:flutter/material.dart';
import 'package:meayar_flutter/meayar.dart';

/// Syrian Ministry of Health (وزارة الصحة) Portal Screen.
class HealthServicePortalScreen extends StatefulWidget {
  const HealthServicePortalScreen({
    super.key,
    this.onOpenDrawer,
  });

  final VoidCallback? onOpenDrawer;

  @override
  State<HealthServicePortalScreen> createState() => _HealthServicePortalScreenState();
}

class _HealthServicePortalScreenState extends State<HealthServicePortalScreen> {
  String _searchQuery = '';
  int _selectedFilterTab = 0;
  final List<String> _filterTabs = ['الكل', 'المواعيد', 'الشهادات', 'اللقاحات', 'الشكاوى'];

  void _openServiceApplicationDialog(BuildContext context, String serviceTitle) {
    String nationalId = '';
    String phoneNumber = '';
    bool isSubmitted = false;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final meayar = context.meayar;
            final colors = meayar.colors;
            final typography = meayar.typography;

            return MeayarDialog(
              title: serviceTitle,
              description: !isSubmitted ? 'يرجى تعبئة البيانات المطلوبة لبدء معاملتك الرسمية.' : null,
              icon: Icon(
                !isSubmitted ? MeayarIcons.document : MeayarIcons.checkCircle,
                color: colors.iconBrand,
                size: 24.0,
              ),
              confirmText: !isSubmitted ? 'متابعة الطلب' : 'إغلاق',
              cancelText: !isSubmitted ? 'إلغاء' : null,
              content: !isSubmitted
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MeayarTextField(
                          label: 'الرقم الوطني',
                          isMandatory: true,
                          placeholder: '11 رقماً — مثال: 01010101010',
                          forceLtrContent: true,
                          onChanged: (val) => nationalId = val,
                          leading: const Icon(MeayarIcons.user),
                        ),
                        const SizedBox(height: 14.0),
                        MeayarTextField(
                          label: 'رقم الهاتف المحمول',
                          isMandatory: true,
                          placeholder: '09xxxxxxxx',
                          forceLtrContent: true,
                          helperText: 'سيصلك رمز تحقق عبر رسالة نصية قصيرة SMS',
                          onChanged: (val) => phoneNumber = val,
                          leading: const Icon(MeayarIcons.phone),
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: colors.backgroundSuccessSubtle,
                        borderRadius: meayar.shapes.small,
                      ),
                      child: Text(
                        'تم قيد طلبك برقم مرجعي #SY-94821. سنرسل إشعاراً عند استكمال المعالجة.',
                        style: typography.textSm.copyWith(color: colors.textSuccess),
                      ),
                    ),
              onConfirm: () {
                if (!isSubmitted) {
                  if (nationalId.isNotEmpty && phoneNumber.isNotEmpty) {
                    setDialogState(() => isSubmitted = true);
                  }
                } else {
                  Navigator.of(dialogContext).pop();
                }
              },
              onCancel: () {
                Navigator.of(dialogContext).pop();
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Stack(
      children: [
        ListView(
            padding: const EdgeInsets.only(bottom: 96.0),
            children: [
              // 1. Official Syrian Banner
              const MeayarOfficialBanner(),

              // 2. Top App Bar
              MeayarTopAppBar(
                title: 'وزارة الصحة',
                subtitle: 'الجمهورية العربية السورية — بوابة الرعاية الصحية',
                leading: IconButton(
                  icon: const Icon(MeayarIcons.menu),
                  onPressed: widget.onOpenDrawer ?? () => MeayarNavigationDrawer.of(context)?.open(),
                  tooltip: 'القائمة الرئيسية',
                ),
              ),

              // 3. Hero Section & Search
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'دليل الخدمات الصحية الموحد',
                      style: typography.headingSm.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'احصل على خدمات المشافي، الرعاية الأولية، والشهادات الطبية الرسمية إلكترونياً.',
                      style: typography.textSm.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: 16.0),
                    MeayarTextField(
                      initialValue: _searchQuery,
                      onChanged: (val) => setState(() => _searchQuery = val),
                      placeholder: 'ابحث عن خدمة، لقاح، مركز صحي، أو مستشفى...',
                      trailing: Icon(MeayarIcons.search, size: 20.0, color: colors.iconSecondary),
                    ),
                  ],
                ),
              ),

              // 4. Quick Service Filter Tabs (Pill style)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: MeayarTabs(
                  tabs: _filterTabs,
                  selectedIndex: _selectedFilterTab,
                  onTabSelected: (i) => setState(() => _selectedFilterTab = i),
                  style: MeayarTabStyle.pill,
                ),
              ),

              // 5. Urgent Notice Banner
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: MeayarAlert(
                  title: 'تنويه رسمي',
                  description: 'تم تفعيل حجز المواعيد المسبقة للعيادات الخارجية والمشافي العامة في دمشق وحلب.',
                  style: MeayarAlertStyle.secondary,
                ),
              ),

              // 6. Section Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'الخدمات الإلكترونية المتاحة',
                      style: typography.heading2xs.copyWith(color: colors.textPrimary),
                    ),
                    Text(
                      '3 خدمات متاحة',
                      style: typography.textXsMedium.copyWith(color: colors.textBrand),
                    ),
                  ],
                ),
              ),

              // 7. Service Card 1
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: MeayarServiceCard(
                  title: 'حجز موعد طبي في المراكز الصحية',
                  description: 'خدمة لحجز مواعيد الفحص السريري، والعيادات التخصصية، ومتابعة الأمراض المزمنة.',
                  tagText: 'خدمة فورية',
                  tagColor: MeayarTagColor.green,
                  icon: MeayarIcons.calendar,
                  metaList: const [
                    MeayarServiceMeta(icon: MeayarIcons.clock, label: 'المدة', value: 'فوري'),
                    MeayarServiceMeta(icon: MeayarIcons.document, label: 'الرسوم', value: 'مجاني'),
                    MeayarServiceMeta(icon: MeayarIcons.building, label: 'القناة', value: 'إلكتروني'),
                  ],
                  onStartService: () => _openServiceApplicationDialog(
                    context,
                    'حجز موعد طبي في المراكز الصحية',
                  ),
                ),
              ),

              // 8. Service Card 2
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: MeayarServiceCard(
                  title: 'إصدار الشهادة الصحية الدولية',
                  description: 'إصدار وتوثيق شهادة الخلو من الأمراض السارية وبطاقات التطعيم المعتمدة دولياً.',
                  tagText: 'تتطلب فحص',
                  tagColor: MeayarTagColor.gold,
                  icon: MeayarIcons.document,
                  metaList: const [
                    MeayarServiceMeta(icon: MeayarIcons.clock, label: 'المدة', value: 'يومان عمل'),
                    MeayarServiceMeta(icon: MeayarIcons.document, label: 'الرسوم', value: '25,000 ل.س'),
                    MeayarServiceMeta(icon: MeayarIcons.building, label: 'القناة', value: 'حضور شخصي'),
                  ],
                  onStartService: () => _openServiceApplicationDialog(
                    context,
                    'إصدار الشهادة الصحية الدولية',
                  ),
                ),
              ),

              // 9. Service Card 3
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: MeayarServiceCard(
                  title: 'منظومة الشكاوى والمقترحات الصحية',
                  description: 'تقديم ومتابعة الشكاوى المتعلقة بالخدمات الطبية، المرافق الصحية، وتوافر الأدوية.',
                  tagText: 'متاح 24/7',
                  tagColor: MeayarTagColor.blue,
                  icon: MeayarIcons.info,
                  metaList: const [
                    MeayarServiceMeta(icon: MeayarIcons.clock, label: 'المدة', value: '48 ساعة'),
                    MeayarServiceMeta(icon: MeayarIcons.document, label: 'الرسوم', value: 'مجاني'),
                    MeayarServiceMeta(icon: MeayarIcons.building, label: 'القناة', value: 'إلكتروني'),
                  ],
                  onStartService: () => _openServiceApplicationDialog(
                    context,
                    'منظومة الشكاوى والمقترحات الصحية',
                  ),
                ),
              ),
            ],
          ),
        ],
      );
  }
}
