import 'package:flutter/material.dart';

import '../../core/grid_models.dart';
import '../../ui/custom_colors.dart';
import '../../widgets/erp_data_grid.dart';
import '../../widgets/erp_list_filter_row.dart';
import '../../widgets/erp_list_toolbar.dart';
import '../../widgets/view_settings_dialog.dart';

// Колонки для экрана Товары
final List<ColumnConfig> productsDefaultColumns = [
  ColumnConfig(key: 'article', title: 'Артикул', width: 120),
  ColumnConfig(key: 'name', title: 'Наименование', width: 250),
  ColumnConfig(key: 'category', title: 'Категория', width: 150),
  ColumnConfig(key: 'stock', title: 'Остаток', width: 100),
  ColumnConfig(key: 'status', title: 'Статус', width: 140),
];

final List<Map<String, dynamic>> mockProducts = [
  {
    'article': 'SCN-001',
    'name': 'Сканер штрихкодов Honeywell',
    'category': 'Оборудование',
    'stock': 24,
    'status': 'В наличии',
  },
  {
    'article': 'LBL-002',
    'name': 'Термоэтикетки 58х40',
    'category': 'Расходники',
    'stock': 8,
    'status': 'Мало',
  },
  {
    'article': 'PAL-003',
    'name': 'Паллета европоддон',
    'category': 'Тара',
    'stock': 156,
    'status': 'В наличии',
  },
  {
    'article': 'WRP-004',
    'name': 'Стрейч-пленка 500мм.',
    'category': 'Расходники',
    'stock': 42,
    'status': 'В наличии',
  },
  {
    'article': 'TSC-005',
    'name': 'ТСД Zebra MC93',
    'category': 'Оборудование',
    'stock': 5,
    'status': 'Мало',
  },
  {
    'article': 'BAT-006',
    'name': 'Батарея для ТСД',
    'category': 'Расходники',
    'stock': 3,
    'status': 'Критично',
  },
];

/// Моковый диалог карточки товара: Название, Артикул, Остаток, Статус.
class ProductProfileDialog extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductProfileDialog({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final name = product['name']?.toString() ?? '—';
    final article = product['article']?.toString() ?? '—';
    final stock = (product['stock'] as num?)?.toInt() ?? 0;
    final status = product['status']?.toString() ?? '—';
    final statusColor = _productStatusColor(context, status);

    return Dialog(
      backgroundColor: context.bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Карточка товара',
                    style: TextStyle(
                      color: context.textMain,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: context.textMuted),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _row(context, 'Название', name),
                    const SizedBox(height: 12),
                    _row(context, 'Артикул', article),
                    const SizedBox(height: 12),
                    _row(context, 'Остаток', stock.toString()),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            'Статус',
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _row(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              color: context.textMuted,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: context.textMain,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  static Color _productStatusColor(BuildContext context, String status) {
    if (status == 'В наличии') {
      return context.brightness == Brightness.dark
          ? Colors.greenAccent
          : Colors.green.shade700;
    }
    if (status == 'Мало') {
      return context.brightness == Brightness.dark
          ? Colors.orangeAccent
          : Colors.orange.shade800;
    }
    if (status == 'Критично') {
      return Colors.redAccent;
    }
    return context.textMuted;
  }
}

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  String _searchQuery = '';
  final TextEditingController _searchCtrl = TextEditingController();
  final ScrollController _tableScrollController = ScrollController();
  late final GridState _gridState =
      GridState(defaultColumns: productsDefaultColumns);

  @override
  void dispose() {
    _searchCtrl.dispose();
    _tableScrollController.dispose();
    _gridState.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredProducts {
    var list = mockProducts.where((p) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        if (!(p['name']?.toString().toLowerCase().contains(q) ?? false) &&
            !(p['article']?.toString().toLowerCase().contains(q) ?? false)) {
          return false;
        }
      }
      for (var f in _gridState.filters.value) {
        if (f.value.isEmpty) {
          continue;
        }
        var fieldVal = p[f.field]?.toString().toLowerCase() ?? '';
        var searchVal = f.value.toLowerCase();
        if (f.operator == 'Содержит' && !fieldVal.contains(searchVal)) {
          return false;
        }
        if (f.operator == 'Равно' && fieldVal != searchVal) {
          return false;
        }
      }
      return true;
    }).toList();

    final sortCol = _gridState.sortColumn.value;
    if (sortCol != null && sortCol.isNotEmpty) {
      final asc = _gridState.isAscending.value;
      list = List.from(list)
        ..sort((a, b) {
          final va = a[sortCol];
          final vb = b[sortCol];
          if (va is num && vb is num) {
            final cmp = va.compareTo(vb);
            return asc ? cmp : -cmp;
          }
          final sa = va?.toString().toLowerCase() ?? '';
          final sb = vb?.toString().toLowerCase() ?? '';
          final cmp = sa.compareTo(sb);
          return asc ? cmp : -cmp;
        });
    }
    return list;
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _searchCtrl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      color: context.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ErpListToolbar(
            title: 'Товары',
            titleIcon: Icons.inventory_2_outlined,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ValueListenableBuilder<List<ColumnConfig>>(
              valueListenable: _gridState.columns,
              builder: (context, cols, _) {
                final visibleCols =
                    cols.where((c) => c.isVisible).toList();
                final tableWidth =
                    ErpDataGrid.tableWidthForColumns(visibleCols);
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      controller: _tableScrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: tableWidth,
                        height: constraints.maxHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ValueListenableBuilder<String>(
                              valueListenable: _gridState.currentViewName,
                              builder: (context, viewName, _) {
                                return ValueListenableBuilder<bool>(
                                  valueListenable: _gridState.isViewModified,
                                  builder: (context, isMod, _) {
                                    return ErpListFilterRow(
                                      searchController: _searchCtrl,
                                      onSearchChanged: (val) {
                                        setState(() {
                                          _searchQuery = val;
                                        });
                                      },
                                      quickFilters: const [],
                                      onClearFilters: _clearFilters,
                                      onAddPressed: () {},
                                      rowWidth: tableWidth,
                                      onSettingsPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (c) => ViewSettingsDialog(
                                            gridState: _gridState,
                                          ),
                                        ).then((_) {
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        });
                                      },
                                      viewName: viewName,
                                      isViewModified: isMod,
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: ErpDataGrid(
                                items: _filteredProducts,
                                columns: visibleCols,
                                cellBuilder: (context, item, col, index) =>
                                    _buildProductCell(context, item, col),
                                onRowTap: (item, index) {
                                  showDialog(
                                    context: context,
                                    builder: (c) => ProductProfileDialog(product: item),
                                  );
                                },
                                horizontalScrollController: _tableScrollController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildProductCell(
    BuildContext context,
    Map<String, dynamic> item,
    ColumnConfig col,
  ) {
    if (col.key == 'stock') {
      final stock = (item['stock'] as num?)?.toInt() ?? 0;
      final isLow = stock < 10;
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          stock.toString(),
          style: TextStyle(
            color: isLow ? Colors.redAccent : context.textMain,
            fontSize: 14,
            fontWeight: isLow ? FontWeight.bold : FontWeight.normal,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    if (col.key == 'status') {
      final status = item['status']?.toString() ?? '-';
      final color = ProductProfileDialog._productStatusColor(context, status);
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        item[col.key]?.toString() ?? '-',
        style: TextStyle(
          color: context.textMain,
          fontSize: 14,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
