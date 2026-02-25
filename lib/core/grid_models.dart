import 'package:flutter/material.dart';

// ============================================================================
// МОДЕЛИ ДЛЯ УНИВЕРСАЛЬНОГО ERP DATAGRID (изоляция состояния по экранам)
// ============================================================================

class ColumnConfig {
  String key;
  String title;
  bool isVisible;
  double width;

  ColumnConfig({
    required this.key,
    required this.title,
    this.isVisible = true,
    this.width = 150,
  });
  ColumnConfig clone() =>
      ColumnConfig(key: key, title: title, isVisible: isVisible, width: width);
}

class FilterCondition {
  String field;
  String operator;
  String value;

  FilterCondition({
    this.field = 'name',
    this.operator = 'Содержит',
    this.value = '',
  });
  FilterCondition clone() =>
      FilterCondition(field: field, operator: operator, value: value);
}

class ViewPreset {
  String name;
  List<ColumnConfig> columns;
  List<FilterCondition> filters;
  final bool isStandard;
  String? sortColumn;
  bool isAscending;

  ViewPreset({
    required this.name,
    required this.columns,
    required this.filters,
    this.isStandard = false,
    this.sortColumn,
    this.isAscending = true,
  });
  ViewPreset clone() => ViewPreset(
        name: name,
        columns: columns.map((c) => c.clone()).toList(),
        filters: filters.map((f) => f.clone()).toList(),
        isStandard: isStandard,
        sortColumn: sortColumn,
        isAscending: isAscending,
      );
}

/// Состояние грида для одного экрана. Каждый экран (Команда, Товары и т.д.)
/// имеет свой экземпляр — колонки, фильтры и пресеты не конфликтуют.
class GridState {
  final List<ColumnConfig> defaultColumns;
  final ValueNotifier<List<ColumnConfig>> columns;
  final ValueNotifier<List<FilterCondition>> filters;
  final ValueNotifier<List<ViewPreset>> presets;
  final ValueNotifier<String> currentViewName;
  final ValueNotifier<bool> isViewModified;
  final ValueNotifier<String?> sortColumn;
  final ValueNotifier<bool> isAscending;

  GridState({
    required this.defaultColumns,
    List<ColumnConfig>? initialColumns,
    List<ViewPreset>? initialPresets,
  })  : columns = ValueNotifier(
          (initialColumns ?? defaultColumns).map((c) => c.clone()).toList(),
        ),
        filters = ValueNotifier([]),
        presets = ValueNotifier(
          initialPresets ??
              [
                ViewPreset(
                  name: 'Стандартный вид',
                  columns: defaultColumns.map((c) => c.clone()).toList(),
                  filters: [],
                  isStandard: true,
                ),
              ],
        ),
        currentViewName = ValueNotifier('Стандартный вид'),
        isViewModified = ValueNotifier(false),
        sortColumn = ValueNotifier<String?>(null),
        isAscending = ValueNotifier<bool>(true);

  List<ColumnConfig> get visibleColumns =>
      columns.value.where((c) => c.isVisible).toList();

  void dispose() {
    columns.dispose();
    filters.dispose();
    presets.dispose();
    currentViewName.dispose();
    isViewModified.dispose();
    sortColumn.dispose();
    isAscending.dispose();
  }
}
