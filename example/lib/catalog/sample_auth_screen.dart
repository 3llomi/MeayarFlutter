import 'package:flutter/material.dart';
import 'package:meayar_flutter/meayar.dart';

/// Official Syrian National Digital Identity Authentication Screen.
class MeayarAuthScreen extends StatefulWidget {
  const MeayarAuthScreen({
    super.key,
    this.onLoginSuccess,
  });

  final VoidCallback? onLoginSuccess;

  @override
  State<MeayarAuthScreen> createState() => _MeayarAuthScreenState();
}

class _MeayarAuthScreenState extends State<MeayarAuthScreen> {
  int _selectedTab = 0;
  final List<String> _authTabs = ['تسجيل الدخول', 'التحقق بالرمز (OTP)', 'حساب جديد'];

  String _nationalId = '01020034567';
  String _password = '';
  String _phoneNumber = '0933123456';
  String _otpCode = '';
  bool _rememberMe = true;
  bool _isLoading = false;
  bool _authSuccess = false;
  bool _isHighContrast = false;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Scaffold(
      backgroundColor: colors.backgroundPage,
      body: Column(
        children: [
          // Official Syrian Top Banner
          const MeayarOfficialBanner(),

          // Accessibility Toolbar
          MeayarAccessibilityToolbar(
            onFontScaleDecrease: () {},
            onFontScaleReset: () {},
            onFontScaleIncrease: () {},
            isHighContrast: _isHighContrast,
            onToggleHighContrast: (val) => setState(() => _isHighContrast = val),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480.0),
                  child: Column(
                    children: [
                      // Syrian Emblem Badge
                      Container(
                        width: 64.0,
                        height: 64.0,
                        decoration: BoxDecoration(
                          color: colors.backgroundBrand,
                          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                        ),
                        alignment: Alignment.center,
                        child: Icon(MeayarIcons.building, color: colors.textInverse, size: 36.0),
                      ),
                      const SizedBox(height: 14.0),

                      Text(
                        'بوابة الهوية الرقمية السورية الموحدة',
                        style: typography.headingSm.copyWith(color: colors.textPrimary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'منظومة النفاذ الإلكتروني الموحد لكافة المعاملات والخدمات الحكومية',
                        style: typography.textSm.copyWith(color: colors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24.0),

                      // Main Auth Card
                      MeayarCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            MeayarTabs(
                              tabs: _authTabs,
                              selectedIndex: _selectedTab,
                              onTabSelected: (i) => setState(() {
                                _selectedTab = i;
                                _authSuccess = false;
                              }),
                              style: MeayarTabStyle.pill,
                            ),
                            const SizedBox(height: 16.0),

                            if (_authSuccess) ...[
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: colors.backgroundSuccessSubtle,
                                  borderRadius: meayar.shapes.small,
                                ),
                                child: Row(
                                  children: [
                                    Icon(MeayarIcons.checkCircle, color: colors.textSuccess, size: 20.0),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'تم التحقق بنجاح',
                                            style: typography.textSmBold.copyWith(color: colors.textSuccess),
                                          ),
                                          Text(
                                            'أهلاً بك، تم تسجيل الدخول بنجاح إلى منظومة الهوية الرقمية.',
                                            style: typography.textXs.copyWith(color: colors.textSecondary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              MeayarButton(
                                text: 'الانتقال إلى لوحة الخدمات',
                                size: MeayarButtonSize.lg,
                                fullWidth: true,
                                onPressed: widget.onLoginSuccess ?? () {},
                              ),
                            ] else if (_selectedTab == 0) ...[
                              MeayarTextField(
                                label: 'الرقم الوطني الموحد (11 رقماً)',
                                isMandatory: true,
                                forceLtrContent: true,
                                initialValue: _nationalId,
                                onChanged: (v) => _nationalId = v,
                                placeholder: '01xxxxxxxx',
                                helperText: 'كما هو مدون في البطاقة الشخصية الصادرة عن السجل المدني',
                                leading: const Icon(MeayarIcons.user),
                              ),
                              const SizedBox(height: 16.0),
                              MeayarTextField(
                                label: 'كلمة المرور الخاصة بالهوية',
                                isMandatory: true,
                                obscureText: true,
                                forceLtrContent: true,
                                initialValue: _password,
                                onChanged: (v) => _password = v,
                                placeholder: '••••••••••••',
                                leading: const Icon(MeayarIcons.lock),
                              ),
                              const SizedBox(height: 12.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: MeayarCheckbox(
                                      value: _rememberMe,
                                      label: 'تذكر هذا الجهاز',
                                      onChanged: (v) => setState(() => _rememberMe = v),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'نسيت كلمة المرور؟',
                                      style: typography.textXsMedium.copyWith(color: colors.textBrand),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              MeayarButton(
                                text: 'تسجيل الدخول إلى البوابة',
                                size: MeayarButtonSize.lg,
                                fullWidth: true,
                                loading: _isLoading,
                                onPressed: () {
                                  setState(() => _isLoading = true);
                                  Future.delayed(const Duration(milliseconds: 600), () {
                                    if (mounted) {
                                      setState(() {
                                        _isLoading = false;
                                        _authSuccess = true;
                                      });
                                    }
                                  });
                                },
                              ),
                            ] else if (_selectedTab == 1) ...[
                              Text(
                                'أدخل رمز التحقق المرسل عبر رسالة SMS إلى هاتفك المسجل لدى المنظومة:',
                                style: typography.textSm.copyWith(color: colors.textSecondary),
                              ),
                              const SizedBox(height: 14.0),
                              MeayarTextField(
                                label: 'رقم الهاتف المحمول',
                                isMandatory: true,
                                forceLtrContent: true,
                                initialValue: _phoneNumber,
                                onChanged: (v) => _phoneNumber = v,
                                leading: const Icon(MeayarIcons.phone),
                              ),
                              const SizedBox(height: 16.0),
                              Center(
                                child: MeayarOtpInput(
                                  length: 4,
                                  value: _otpCode,
                                  onChanged: (v) => _otpCode = v,
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              MeayarButton(
                                text: 'تأكيد الرمز والدخول',
                                size: MeayarButtonSize.lg,
                                fullWidth: true,
                                onPressed: () => setState(() => _authSuccess = true),
                              ),
                            ] else ...[
                              MeayarTextField(
                                label: 'الاسم الثلاثي',
                                isMandatory: true,
                                placeholder: 'حمزة الخطيب',
                                leading: const Icon(MeayarIcons.user),
                              ),
                              const SizedBox(height: 14.0),
                              MeayarTextField(
                                label: 'الرقم الوطني',
                                isMandatory: true,
                                forceLtrContent: true,
                                placeholder: '01xxxxxxxx',
                                leading: const Icon(MeayarIcons.lock),
                              ),
                              const SizedBox(height: 14.0),
                              MeayarTextField(
                                label: 'رقم الهاتف',
                                isMandatory: true,
                                forceLtrContent: true,
                                placeholder: '09xxxxxxxx',
                                leading: const Icon(MeayarIcons.phone),
                              ),
                              const SizedBox(height: 20.0),
                              MeayarButton(
                                text: 'إنشاء حساب جديد',
                                size: MeayarButtonSize.lg,
                                fullWidth: true,
                                onPressed: () => setState(() => _authSuccess = true),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
