import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/theme/meayar_theme.dart';
import '../indicators/meayar_indicators.dart';
import '../inputs/meayar_form_field_wrapper.dart';

class MeayarFileItem {
  const MeayarFileItem({
    required this.id,
    required this.name,
    required this.sizeString,
    this.progress = 1.0,
    this.isError = false,
    this.errorMessage,
  });

  final String id;
  final String name;
  final String sizeString;
  final double progress;
  final bool isError;
  final String? errorMessage;
}

/// Official MEAYAR Attached File Row showing success, in-progress, or error states.
class MeayarAttachedFileRow extends StatelessWidget {
  const MeayarAttachedFileRow({
    super.key,
    required this.file,
    required this.onRemove,
    this.fallbackErrorMessage = 'فشل الرفع',
  });

  final MeayarFileItem file;
  final VoidCallback onRemove;
  final String fallbackErrorMessage;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final effectiveFailedText = fallbackErrorMessage;

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colors.backgroundSurface,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        border: Border.all(
          color: file.isError ? colors.borderError : colors.borderSubtle,
          width: 1.0,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: file.isError ? colors.backgroundErrorSubtle : colors.backgroundBrandSubtle,
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                ),
                alignment: Alignment.center,
                child: Icon(
                  MeayarIcons.document,
                  color: file.isError ? colors.textError : colors.iconBrand,
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name,
                      style: typography.textSmMedium.copyWith(color: colors.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      file.isError ? (file.errorMessage ?? effectiveFailedText) : file.sizeString,
                      style: typography.textXs.copyWith(
                        color: file.isError ? colors.textError : colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(MeayarIcons.close, size: 16.0, color: colors.iconSecondary),
                onPressed: onRemove,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28.0, minHeight: 28.0),
              ),
            ],
          ),
          if (file.progress < 1.0 && !file.isError) ...[
            const SizedBox(height: 8.0),
            MeayarProgressBar(value: file.progress, height: 4.0),
          ],
        ],
      ),
    );
  }
}

/// Official MEAYAR File Upload & Attachment Dropzone widget.
class MeayarFileUpload extends StatelessWidget {
  const MeayarFileUpload({
    super.key,
    required this.onSelectFiles,
    this.label,
    this.isMandatory = false,
    this.dropzoneTitle = 'انقر لاختيار ملف من جهازك',
    this.hintText = 'PDF, JPG, PNG (الحد الأقصى 10 ميغابايت)',
    this.fallbackErrorMessage = 'فشل الرفع',
    this.files = const [],
    this.onRemoveFile,
  });

  final VoidCallback onSelectFiles;
  final String? label;
  final bool isMandatory;
  final String dropzoneTitle;
  final String hintText;
  final String fallbackErrorMessage;
  final List<MeayarFileItem> files;
  final ValueChanged<MeayarFileItem>? onRemoveFile;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final effectiveTitle = dropzoneTitle;
    final effectiveHint = hintText;

    final uploadContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropzone / Select Trigger
        InkWell(
          onTap: onSelectFiles,
          borderRadius: meayar.shapes.medium,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: colors.backgroundSubtle,
              borderRadius: meayar.shapes.medium,
              border: Border.all(
                color: colors.borderDefault,
                width: 1.5,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: colors.backgroundBrandSubtle,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(MeayarIcons.upload, color: colors.iconBrand, size: 24.0),
                ),
                const SizedBox(height: 12.0),
                Text(
                  effectiveTitle,
                  style: typography.textSmMedium.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 4.0),
                Text(
                  effectiveHint,
                  style: typography.textXs.copyWith(color: colors.textTertiary),
                ),
              ],
            ),
          ),
        ),

        // Attached Files List
        if (files.isNotEmpty) ...[
          const SizedBox(height: 12.0),
          Column(
            children: files.map((file) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: MeayarAttachedFileRow(
                  file: file,
                  fallbackErrorMessage: fallbackErrorMessage,
                  onRemove: () => onRemoveFile?.call(file),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );

    return MeayarFormFieldWrapper(
      label: label,
      isMandatory: isMandatory,
      child: uploadContent,
    );
  }
}
