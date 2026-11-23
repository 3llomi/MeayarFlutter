import 'package:flutter/material.dart';
import '../../core/theme/meayar_colors.dart';
import '../../core/theme/meayar_theme.dart';

/// Official Syrian State Identity Banner ("الجمهورية العربية السورية — بوابة الخدمات الرقمية").
/// Displayed at the very top of digital public portals.
/// Keeps authentic Syrian State Identity in Arabic by default.
class MeayarOfficialBanner extends StatelessWidget {
  const MeayarOfficialBanner({
    super.key,
    this.title = 'الجمهورية العربية السورية',
    this.subtitle = 'بوابة الخدمات الرقمية الموحدة',
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Container(
      width: double.infinity,
      color: colors.backgroundBrand,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6.0,
            height: 6.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MeayarPrimitives.syrianGold500,
            ),
          ),
          const SizedBox(width: 8.0),
          Text(
            '$title • $subtitle',
            style: typography.text2xsMedium.copyWith(color: colors.textInverse),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: 6.0,
            height: 6.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: MeayarPrimitives.syrianGold500,
            ),
          ),
        ],
      ),
    );
  }
}
