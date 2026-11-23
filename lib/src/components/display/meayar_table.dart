import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/localization/meayar_localizations.dart';
import '../../core/theme/meayar_theme.dart';

/// Single column definition for [MeayarTable].
class MeayarColumn<T> {
  const MeayarColumn({
    required this.title,
    required this.cellBuilder,
    this.width,
    this.alignment = AlignmentDirectional.centerStart,
  });

  final String title;
  final Widget Function(T item) cellBuilder;
  final double? width;
  final AlignmentDirectional alignment;
}

/// Official MEAYAR Data Table component with zebra striping, Syrian styling,
/// responsive horizontal scroll, and lazy row virtualization support.
class MeayarTable<T> extends StatelessWidget {
  const MeayarTable({
    super.key,
    required this.columns,
    required this.items,
    this.zebraStriping = true,
    this.emptyMessage,
    this.borderRadius,
    this.maxHeight,
    this.isLazy = false,
    this.minWidth,
  });

  final List<MeayarColumn<T>> columns;
  final List<T> items;
  final bool zebraStriping;
  final String? emptyMessage;
  final BorderRadius? borderRadius;

  /// Optional maximum height for the table. When provided, rows scroll
  /// lazily via [ListView.builder] beneath a sticky header.
  final double? maxHeight;

  /// Whether to render rows lazily using a virtualized [ListView.builder].
  final bool isLazy;

  /// Optional minimum width for the table. If null, automatically calculated
  /// from explicit column widths and row padding.
  final double? minWidth;

  @override
  Widget build(BuildContext context) {
    final meayar = context.meayar;
    final colors = meayar.colors;
    final typography = meayar.typography;
    final shape = borderRadius ?? meayar.shapes.medium;
    final effectiveEmptyMessage = emptyMessage ?? MeayarLocalizations.of(context).tableEmptyMessage;

    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: colors.backgroundSurface,
          borderRadius: shape,
          border: Border.all(color: colors.borderSubtle, width: 1.0),
        ),
        alignment: Alignment.center,
        child: Text(
          effectiveEmptyMessage,
          style: typography.textSm.copyWith(color: colors.textTertiary),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : 320.0;
        const double horizontalRowPadding = 32.0; // 16.0 on start + 16.0 on end
        final unsetColumnsCount = columns.where((c) => c.width == null).length;
        final totalExplicitWidth = columns.fold<double>(0.0, (sum, c) => sum + (c.width ?? 0.0));
        final minContentWidth = totalExplicitWidth + (unsetColumnsCount * 80.0) + horizontalRowPadding;
        final effectiveMinWidth = minWidth != null
            ? math.max(minWidth!, minContentWidth)
            : minContentWidth;
        final effectiveTableWidth = math.max(availableWidth, effectiveMinWidth);

        Widget buildRow(int index) {
          final item = items[index];
          final isZebra = zebraStriping && index.isOdd;
          final rowBg = isZebra ? colors.backgroundSubtle : colors.backgroundSurface;

          return Container(
            color: rowBg,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: columns.map((col) {
                final cell = Align(
                  alignment: col.alignment,
                  child: col.cellBuilder(item),
                );
                if (col.width != null) {
                  return SizedBox(width: col.width, child: cell);
                }
                return Expanded(child: cell);
              }).toList(),
            ),
          );
        }

        final headerRow = Container(
          color: colors.backgroundMuted,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: columns.map((col) {
              final headerText = Text(
                col.title,
                style: typography.textXsMedium.copyWith(color: colors.textSecondary),
              );
              if (col.width != null) {
                return SizedBox(width: col.width, child: headerText);
              }
              return Expanded(child: headerText);
            }).toList(),
          ),
        );

        final useLazy = isLazy || maxHeight != null;
        final tableBody = useLazy
            ? SizedBox(
                height: maxHeight ?? (constraints.maxHeight.isFinite ? constraints.maxHeight : 400.0),
                child: Column(
                  children: [
                    headerRow,
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: items.length,
                        itemBuilder: (context, index) => buildRow(index),
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerRow,
                  ...List.generate(items.length, buildRow),
                ],
              );

        return Container(
          decoration: BoxDecoration(
            color: colors.backgroundSurface,
            borderRadius: shape,
            border: Border.all(color: colors.borderSubtle, width: 1.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: effectiveTableWidth,
              child: tableBody,
            ),
          ),
        );
      },
    );
  }
}
