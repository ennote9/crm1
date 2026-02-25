import 'package:flutter/material.dart';

import '../ui/custom_colors.dart';

/// Отдельная плашка «строка быстрой фильтрации» над таблицей: поиск, фильтры, сброс, настройки вида, добавление.
/// Не смешивается ни с заголовком, ни с таблицей. Без собственной полосы прокрутки.
/// Если задан [rowWidth], строка растягивается на эту ширину и кнопка «Добавить» прижимается к правому краю (выравнивание с таблицей).
class ErpListFilterRow extends StatelessWidget {
  final TextEditingController searchController;
  final void Function(String) onSearchChanged;
  final List<Widget> quickFilters;
  final VoidCallback onClearFilters;
  final VoidCallback onAddPressed;
  final VoidCallback onSettingsPressed;
  final String viewName;
  final bool isViewModified;
  /// Ширина строки (обычно ширина таблицы), чтобы кнопка «Добавить» была справа.
  final double? rowWidth;

  const ErpListFilterRow({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
    required this.quickFilters,
    required this.onClearFilters,
    required this.onAddPressed,
    required this.onSettingsPressed,
    required this.viewName,
    required this.isViewModified,
    this.rowWidth,
  });

  @override
  Widget build(BuildContext context) {
    final content = Row(
      mainAxisSize: rowWidth != null ? MainAxisSize.max : MainAxisSize.min,
      children: [
              SizedBox(
                width: 280,
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  style: TextStyle(
                    color: context.textMain,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Поиск',
                    hintStyle: TextStyle(
                      color: context.textMuted,
                      fontSize: 13,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: context.textMuted,
                      size: 18,
                    ),
                    filled: true,
                    fillColor: context.bg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ...quickFilters.map(
                (w) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SizedBox(width: 180, child: w),
                ),
              ),
              IconButton(
                onPressed: onClearFilters,
                icon: Icon(
                  Icons.refresh,
                  color: context.textMuted,
                  size: 20,
                ),
                tooltip: 'Сбросить фильтры',
              ),
              const SizedBox(width: 8),
              Container(
                margin: const EdgeInsets.only(right: 12),
                height: 44,
                child: OutlinedButton.icon(
                  icon: Icon(
                    Icons.tune,
                    size: 16,
                    color: isViewModified
                        ? context.orange
                        : context.textMain,
                  ),
                  label: Text(
                    viewName + (isViewModified ? '*' : ''),
                    style: TextStyle(
                      color: context.textMain,
                    ),
                  ),
                  onPressed: onSettingsPressed,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: context.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                ),
              ),
        if (rowWidth != null) const Spacer(),
        SizedBox(
          height: 44,
          child: ElevatedButton.icon(
            onPressed: onAddPressed,
            icon: const Icon(Icons.add),
            label: const Text('Добавить'),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );

    Widget body = ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: rowWidth != null
            ? SizedBox(width: rowWidth, child: content)
            : content,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.border),
      ),
      child: body,
    );
  }
}
