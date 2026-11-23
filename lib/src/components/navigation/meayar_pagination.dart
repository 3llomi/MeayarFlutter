import 'package:flutter/material.dart';
import '../../core/icons/meayar_icons.dart';
import '../../core/localization/meayar_localizations.dart';
import '../../core/theme/meayar_theme.dart';

/// Calculates visible page numbers with ellipsis (-1) for large page sets.
List<int> _calculatePaginationPages(int currentPage, int totalPages, int maxVisible) {
  if (totalPages <= maxVisible) {
    return List.generate(totalPages, (i) => i + 1);
  }
  final pages = <int>[];
  pages.add(1);
  if (currentPage > 3 && maxVisible >= 5) pages.add(-1);
  final windowSize = maxVisible <= 3 ? 1 : 3;
  final start = (currentPage - windowSize ~/ 2).clamp(2, totalPages - 1);
  final end = (currentPage + windowSize ~/ 2).clamp(2, totalPages - 1);
  for (int i = start; i <= end; i++) {
    if (!pages.contains(i)) pages.add(i);
  }
  if (currentPage < totalPages - 2 && maxVisible >= 5) pages.add(-1);
  if (!pages.contains(totalPages)) pages.add(totalPages);
  return pages;
}

/// Official MEAYAR Pagination control.
/// Features smart page boxes, optional text labels ("السابق" / "التالي"), smart ellipsis windowing, and direction-aware RTL/LTR support.
class MeayarPagination extends StatelessWidget {
  const MeayarPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.onPageSelected,
    this.onPageChanged,
    this.showLabels = false,
    this.previousLabel,
    this.nextLabel,
  });

  final int currentPage; // 1-based
  final int totalPages;
  final ValueChanged<int>? onPageSelected;
  final ValueChanged<int>? onPageChanged;
  final bool showLabels;
  final String? previousLabel;
  final String? nextLabel;

  void _selectPage(int page) {
    if (page < 1 || page > totalPages) return;
    onPageSelected?.call(page);
    onPageChanged?.call(page);
  }

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final loc = MeayarLocalizations.of(context);
    final isEnglish = loc.locale.languageCode == 'en';
    final effectivePreviousLabel = previousLabel ??
        (isEnglish ? loc.paginationPrevious : 'السابق');
    final effectiveNextLabel = nextLabel ??
        (isEnglish ? loc.paginationNext : 'التالي');

    final prevIcon =  MeayarIcons.chevronLeft;
    final nextIcon =  MeayarIcons.chevronRight;

    const buttonSize = 36.0;
    const spacing = 6.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 380.0;
        final actualButtonSize = isCompact ? 32.0 : buttonSize;
        final actualSpacing = isCompact ? 4.0 : spacing;
        final maxPagesToShow = (showLabels && isCompact) ? 3 : 7;
        final visiblePages = _calculatePaginationPages(currentPage, totalPages, maxPagesToShow);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Previous Button (on start side)
            Material(
              color: colors.backgroundSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: colors.borderSubtle, width: 1.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(6.0),
                onTap: currentPage > 1 ? () => _selectPage(currentPage - 1) : null,
                child: Container(
                  height: actualButtonSize,
                  padding: EdgeInsets.symmetric(
                    horizontal: showLabels ? (isCompact ? 6.0 : 10.0) : 0.0,
                  ),
                  constraints: BoxConstraints(
                    minWidth: showLabels ? 0.0 : actualButtonSize,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        prevIcon,
                        size: 16.0,
                        color: currentPage > 1 ? colors.iconPrimary : colors.iconDisabled,
                      ),
                      if (showLabels) ...[
                        const SizedBox(width: 4.0),
                        Text(
                          effectivePreviousLabel,
                          style: (isCompact ? typography.textXsMedium : typography.textSmMedium).copyWith(
                            color: currentPage > 1 ? colors.textPrimary : colors.textDisabled,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(width: actualSpacing),

            // Numbered Page Buttons with smart ellipsis
            ...List.generate(visiblePages.length, (i) {
              final pageNumber = visiblePages[i];
              if (pageNumber == -1) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: actualSpacing / 2),
                  child: SizedBox(
                    width: actualButtonSize,
                    height: actualButtonSize,
                    child: Center(
                      child: Text(
                        '...',
                        style: typography.textSmMedium.copyWith(color: colors.textTertiary),
                      ),
                    ),
                  ),
                );
              }

              final isSelected = pageNumber == currentPage;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: actualSpacing / 2),
                child: Material(
                  color: isSelected ? colors.backgroundBrand : colors.backgroundSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: isSelected
                        ? BorderSide.none
                        : BorderSide(color: colors.borderSubtle, width: 1.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(6.0),
                    onTap: () => _selectPage(pageNumber),
                    child: Container(
                      width: actualButtonSize,
                      height: actualButtonSize,
                      alignment: Alignment.center,
                      child: Text(
                        '$pageNumber',
                        style: (isSelected ? typography.textSmBold : typography.textSm).copyWith(
                          color: isSelected ? colors.textInverse : colors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),

            SizedBox(width: actualSpacing),

            // Next Button (on end side)
            Material(
              color: colors.backgroundSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: colors.borderSubtle, width: 1.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(6.0),
                onTap: currentPage < totalPages ? () => _selectPage(currentPage + 1) : null,
                child: Container(
                  height: actualButtonSize,
                  padding: EdgeInsets.symmetric(
                    horizontal: showLabels ? (isCompact ? 6.0 : 10.0) : 0.0,
                  ),
                  constraints: BoxConstraints(
                    minWidth: showLabels ? 0.0 : actualButtonSize,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showLabels) ...[
                        Text(
                          effectiveNextLabel,
                          style: (isCompact ? typography.textXsMedium : typography.textSmMedium).copyWith(
                            color: currentPage < totalPages ? colors.textPrimary : colors.textDisabled,
                          ),
                        ),
                        const SizedBox(width: 4.0),
                      ],
                      Icon(
                        nextIcon,
                        size: 16.0,
                        color: currentPage < totalPages ? colors.iconPrimary : colors.iconDisabled,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
