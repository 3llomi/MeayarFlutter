import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
import '../buttons/meayar_button.dart';

/// Official MEAYAR Document Card component.
class MeayarDocumentCard extends StatelessWidget {
  const MeayarDocumentCard({
    super.key,
    required this.title,
    required this.fileType,
    required this.fileSize,
    required this.onDownload,
  });

  final String title;
  final String fileType;
  final String fileSize;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: colors.backgroundSurface,
        borderRadius: meayar.shapes.medium,
        border: Border.all(color: colors.borderSubtle, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: colors.backgroundBrandSubtle,
              borderRadius: meayar.shapes.small,
            ),
            child: Icon(MeayarIcons.document, color: colors.iconBrand, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: typography.textSmBold.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '$fileType • $fileSize',
                  style: typography.text2xs.copyWith(color: colors.textTertiary),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          MeayarButton(
            text: 'تحميل',
            onPressed: onDownload,
            variant: MeayarButtonVariant.outlined,
            size: MeayarButtonSize.sm,
            leading: const Icon(MeayarIcons.download),
          ),
        ],
      ),
    );
  }
}

/// Official MEAYAR Citizen Feedback widget ("هل كان هذا المحتوى مفيداً؟").
class MeayarPageFeedback extends StatefulWidget {
  const MeayarPageFeedback({
    super.key,
    this.onSubmitted,
  });

  final ValueChanged<bool>? onSubmitted;

  @override
  State<MeayarPageFeedback> createState() => _MeayarPageFeedbackState();
}

class _MeayarPageFeedbackState extends State<MeayarPageFeedback> {
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colors.backgroundSubtle,
        borderRadius: meayar.shapes.small,
        border: Border.all(color: colors.borderSubtle, width: 1.0),
      ),
      child: _submitted
          ? Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MeayarIcons.checkCircle,
                    color: colors.iconBrand,
                    size: 20.0,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    'شكراً لمشاركتنا رأيك القيّم لتحسين خدماتنا!',
                    style: typography.textSmMedium.copyWith(color: colors.textPrimary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'هل كانت هذه الصفحة مفيدة؟',
                  style: typography.textSmMedium.copyWith(color: colors.textPrimary),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MeayarButton(
                      text: 'نعم 👍',
                      onPressed: () {
                        setState(() => _submitted = true);
                        widget.onSubmitted?.call(true);
                      },
                      variant: MeayarButtonVariant.outlined,
                      size: MeayarButtonSize.sm,
                    ),
                    const SizedBox(width: 8.0),
                    MeayarButton(
                      text: 'لا',
                      onPressed: () {
                        setState(() => _submitted = true);
                        widget.onSubmitted?.call(false);
                      },
                      variant: MeayarButtonVariant.ghost,
                      size: MeayarButtonSize.sm,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
