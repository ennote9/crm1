import 'package:flutter/material.dart';

import '../core/grid_models.dart';
import '../ui/custom_colors.dart';

/// Универсальный ERP-датагрид: шапка, горизонтальный скролл, строки с кастомными ячейками и опциональным меню (три точки).
/// Ширина таблицы = сумма ширин колонок + колонка меню. Внутри скролла только фиксированные ширины (SizedBox), без Expanded/Flexible.
/// Если передан [horizontalScrollController], грид не создаёт свой скролл и рисует только контент — тогда обёртка скролла снаружи (например, вместе со строкой фильтров) задаёт общую ширину.
class ErpDataGrid extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final List<ColumnConfig> columns;
  final Widget Function(
    BuildContext context,
    Map<String, dynamic> item,
    ColumnConfig col,
    int index,
  ) cellBuilder;
  final List<PopupMenuEntry<String>> Function(Map<String, dynamic> item)?
      menuBuilder;
  final void Function(String value, Map<String, dynamic> item, int index)?
      onMenuSelect;
  final void Function(Map<String, dynamic> item, int index)? onRowTap;
  /// Если задан, грид не оборачивается в SingleChildScrollView — контент рисуется с шириной таблицы для общей прокрутки с строкой фильтров.
  final ScrollController? horizontalScrollController;

  const ErpDataGrid({
    super.key,
    required this.items,
    required this.columns,
    required this.cellBuilder,
    this.menuBuilder,
    this.onMenuSelect,
    this.onRowTap,
    this.horizontalScrollController,
  });

  /// Ширина таблицы по колонкам (для выравнивания строки фильтров и общего скролла).
  static double tableWidthForColumns(List<ColumnConfig> columns) {
    const double menuColumnWidth = 80;
    const double rowPaddingH = 24;
    final colsWidth =
        columns.fold<double>(0.0, (sum, c) => sum + c.width);
    return colsWidth + menuColumnWidth + rowPaddingH * 2;
  }

  @override
  State<ErpDataGrid> createState() => _ErpDataGridState();
}

class _ErpDataGridState extends State<ErpDataGrid> {
  static const double _menuColumnWidth = 80;
  static const double _headerPaddingH = 24;
  static const double _headerPaddingV = 16;
  static const double _rowPaddingH = 24;
  static const double _rowPaddingV = 8;

  final ScrollController _horizontalScrollController = ScrollController();

  double get _totalTableWidth {
    final colsWidth = widget.columns.fold<double>(
      0.0,
      (sum, c) => sum + c.width,
    );
    return colsWidth + _menuColumnWidth + _rowPaddingH * 2;
  }

  @override
  void dispose() {
    if (widget.horizontalScrollController == null) {
      _horizontalScrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = _totalTableWidth;
    final useExternalScroll = widget.horizontalScrollController != null;

    Widget content = SizedBox(
      width: totalWidth,
      child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(context),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.surface,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: ListView.separated(
                        itemCount: widget.items.length,
                        separatorBuilder: (context, index) => Divider(
                          color: context.border,
                          height: 1,
                        ),
                        itemBuilder: (context, index) {
                          final item = widget.items[index];
                          final rowContent = Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: _rowPaddingH,
                              vertical: _rowPaddingV,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ...widget.columns.map(
                                  (c) => SizedBox(
                                    width: c.width,
                                    child: widget.cellBuilder(
                                        context, item, c, index),
                                  ),
                                ),
                                SizedBox(
                                  width: _menuColumnWidth - _rowPaddingH,
                                  child: (widget.menuBuilder != null &&
                                          widget.onMenuSelect != null)
                                      ? PopupMenuButton<String>(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: context.textMuted,
                                          ),
                                          color: context.hover,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          onSelected: (value) =>
                                              widget.onMenuSelect!(
                                                  value, item, index),
                                          itemBuilder: (context) =>
                                              widget.menuBuilder!(item),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          );
                          if (widget.onRowTap != null) {
                            return InkWell(
                              onTap: () => widget.onRowTap!(item, index),
                              hoverColor: context.hover,
                              child: rowContent,
                            );
                          }
                          return rowContent;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );

    if (useExternalScroll) {
      return content;
    }
    return SingleChildScrollView(
      controller: _horizontalScrollController,
      scrollDirection: Axis.horizontal,
      child: content,
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _headerPaddingH,
        vertical: _headerPaddingV,
      ),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          ...widget.columns.map(
            (c) => SizedBox(
              width: c.width,
              child: Text(
                c.title.toUpperCase(),
                style: TextStyle(
                  color: context.textMuted,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: _menuColumnWidth - _headerPaddingH),
        ],
      ),
    );
  }
}
