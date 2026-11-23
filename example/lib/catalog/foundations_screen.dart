import 'package:flutter/material.dart';
import 'package:meayar_flutter/meayar.dart';

/// Official Syrian Visual Identity Design Foundations Screen.
/// Displays raw color primitives, typography scale, and corner radiuses.
class FoundationsScreen extends StatelessWidget {
  const FoundationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 96.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'أساسيات النظام (Foundations)',
                style: typography.headingMd.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: 4.0),
              Text(
                'القيم المستخرجة مباشرة من معيار: ألوان الهوية السورية، درجات الخطوط، والحواف المنحنية.',
                style: typography.textSm.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 20.0),

          // Syrian State Green Palette
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الأخضر السوري (Syrian Green Primitives)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 12.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: const [
                    _ColorSwatch(name: 'Brand 400', color: MeayarPrimitives.syrianGreen400, hex: '#094239', isDark: true),
                    _ColorSwatch(name: 'Green 500', color: MeayarPrimitives.syrianGreen500, hex: '#002623', isDark: true),
                    _ColorSwatch(name: 'Green 300', color: MeayarPrimitives.syrianGreen300, hex: '#427F77', isDark: true),
                    _ColorSwatch(name: 'Green 200', color: MeayarPrimitives.syrianGreen200, hex: '#3B877B', isDark: false),
                    _ColorSwatch(name: 'Green 100', color: MeayarPrimitives.syrianGreen100, hex: '#53A99C', isDark: false),
                    _ColorSwatch(name: 'Green 0', color: MeayarPrimitives.syrianGreen0, hex: '#D8DFDE', isDark: false),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // Syrian Gold Palette
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'الذهب السوري (Syrian Gold Primitives)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 12.0),
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: const [
                    _ColorSwatch(name: 'Gold 800', color: MeayarPrimitives.syrianGold800, hex: '#4D4532', isDark: true),
                    _ColorSwatch(name: 'Gold 700', color: MeayarPrimitives.syrianGold700, hex: '#706649', isDark: true),
                    _ColorSwatch(name: 'Gold 500', color: MeayarPrimitives.syrianGold500, hex: '#B8A678', isDark: false),
                    _ColorSwatch(name: 'Gold 400', color: MeayarPrimitives.syrianGold400, hex: '#C6B893', isDark: false),
                    _ColorSwatch(name: 'Gold 300', color: MeayarPrimitives.syrianGold300, hex: '#D4CAAE', isDark: false),
                    _ColorSwatch(name: 'Gold 200', color: MeayarPrimitives.syrianGold200, hex: '#E3DBC9', isDark: false),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          // Typography Scale
          MeayarCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'سلّم الخطوط (Qomra Arabic)',
                  style: typography.heading2xs.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 12.0),
                Text('Heading XL (40sp / 48lh Bold)', style: typography.headingXl.copyWith(color: colors.textPrimary)),
                const SizedBox(height: 8.0),
                Text('Heading LG (36sp / 44lh Bold)', style: typography.headingLg.copyWith(color: colors.textPrimary)),
                const SizedBox(height: 8.0),
                Text('Heading MD (32sp / 40lh Bold)', style: typography.headingMd.copyWith(color: colors.textPrimary)),
                const SizedBox(height: 8.0),
                Text('Heading SM (28sp / 36lh SemiBold)', style: typography.headingSm.copyWith(color: colors.textPrimary)),
                const SizedBox(height: 8.0),
                Text('Heading XS (24sp / 32lh SemiBold)', style: typography.headingXs.copyWith(color: colors.textPrimary)),
                const SizedBox(height: 8.0),
                Text('Heading 2XS (20sp / 24lh Medium)', style: typography.heading2xs.copyWith(color: colors.textPrimary)),
                const SizedBox(height: 16.0),
                Text('Text XL (20sp) — نص كبير للقراءة والعناوين الفرعية', style: typography.textXl.copyWith(color: colors.textSecondary)),
                const SizedBox(height: 6.0),
                Text('Text LG (18sp) — نص مقروء ومريح للفقرات البارزة', style: typography.textLg.copyWith(color: colors.textSecondary)),
                const SizedBox(height: 6.0),
                Text('Text MD (16sp) — النص الأساسي الافتراضي لجميع الواجهات', style: typography.textMd.copyWith(color: colors.textSecondary)),
                const SizedBox(height: 6.0),
                Text('Text SM (14sp) — النصوص المساعدة وحقول الإدخال والأزرار', style: typography.textSm.copyWith(color: colors.textSecondary)),
                const SizedBox(height: 6.0),
                Text('Text XS (12sp) — التسميات الإيضاحية والشارات والتواريخ', style: typography.textXs.copyWith(color: colors.textSecondary)),
                const SizedBox(height: 6.0),
                Text('Text 2XS (10sp) — الملاحظات المصغرة والأرقام الدقيقة', style: typography.text2xs.copyWith(color: colors.textSecondary)),
              ],
            ),
          ),
        ],
      );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.name,
    required this.color,
    required this.hex,
    required this.isDark,
  });

  final String name;
  final Color color;
  final String hex;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final typography = context.meayarTypography;

    return Container(
      width: 96.0,
      height: 72.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1.0),
      ),
      alignment: AlignmentDirectional.bottomStart,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: typography.textXsMedium.copyWith(
              color: isDark ? Colors.white : const Color(0xFF0D0D12),
            ),
          ),
          Text(
            hex,
            style: typography.text2xs.copyWith(
              color: isDark ? Colors.white.withValues(alpha: 0.8) : const Color(0xFF36394A),
            ),
          ),
        ],
      ),
    );
  }
}
