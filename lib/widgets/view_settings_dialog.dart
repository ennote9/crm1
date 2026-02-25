import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/grid_models.dart';
import '../layout/responsive_wrapper.dart';
import '../ui/custom_colors.dart';

/// Диалог настройки представления (колонки + фильтры + пресеты). Работает с переданным [GridState],
/// чтобы каждый экран имел свой независимый набор колонок, фильтров и пресетов.
class ViewSettingsDialog extends StatefulWidget {
  final GridState gridState;

  const ViewSettingsDialog({super.key, required this.gridState});

  @override
  State<ViewSettingsDialog> createState() => _ViewSettingsDialogState();
}

class _ViewSettingsDialogState extends State<ViewSettingsDialog> {
  late List<ColumnConfig> tempCols;
  late List<FilterCondition> tempFilters;
  late String currentPreset;
  late String? tempSortColumn;
  late bool tempIsAscending;
  bool isModified = false;

  GridState get gridState => widget.gridState;

  @override
  void initState() {
    super.initState();
    tempCols = gridState.columns.value.map((c) => c.clone()).toList();
    tempFilters = gridState.filters.value.map((f) => f.clone()).toList();
    currentPreset = gridState.currentViewName.value;
    tempSortColumn = gridState.sortColumn.value;
    tempIsAscending = gridState.isAscending.value;
    isModified = gridState.isViewModified.value;
  }

  void _applyPreset(ViewPreset preset) {
    setState(() {
      currentPreset = preset.name;
      tempCols = preset.columns.map((c) => c.clone()).toList();
      tempFilters = preset.filters.map((f) => f.clone()).toList();
      tempSortColumn = preset.sortColumn;
      tempIsAscending = preset.isAscending;
      isModified = false;
    });
  }

  void _markAsModified() {
    if (!isModified) {
      setState(() {
        isModified = true;
      });
    }
  }

  void _deletePreset(String name) {
    if (name == 'Стандартный вид') return;
    setState(() {
      gridState.presets.value = List.from(gridState.presets.value)
        ..removeWhere((p) => p.name == name);
      _applyPreset(gridState.presets.value.first);
    });
  }

  void _renamePreset(String oldName) {
    if (oldName == 'Стандартный вид') return;
    final ctrl = TextEditingController(text: oldName);
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        backgroundColor: context.bg,
        title: Text(
          'Переименовать пресет',
          style: TextStyle(color: context.textMain),
        ),
        content: TextField(
          controller: ctrl,
          style: TextStyle(color: context.textMain),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(c);
            },
            child: Text('Отмена', style: TextStyle(color: context.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              final newName = ctrl.text.trim();
              if (newName.isNotEmpty &&
                  !gridState.presets.value.any((p) => p.name == newName)) {
                final list = List<ViewPreset>.from(gridState.presets.value);
                final idx = list.indexWhere((p) => p.name == oldName);
                if (idx != -1) {
                  list[idx].name = newName;
                  gridState.presets.value = list;
                  setState(() {
                    currentPreset = newName;
                  });
                }
                Navigator.pop(c);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: context.primary),
            child: const Text(
              'Сохранить',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _saveAsNewPreset() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        backgroundColor: context.bg,
        title: Text(
          'Сохранить пресет',
          style: TextStyle(
            color: context.textMain,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: ctrl,
          style: TextStyle(color: context.textMain),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            hintText: 'Мой новый вид',
            hintStyle: TextStyle(color: context.textMuted),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(c);
            },
            child: Text('Отмена', style: TextStyle(color: context.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              final name = ctrl.text.trim();
              if (name.isEmpty) {
                return;
              }

              final existingIdx =
                  gridState.presets.value.indexWhere((p) => p.name == name);
              if (existingIdx != -1) {
                if (gridState.presets.value[existingIdx].isStandard) {
                  return;
                }
                showDialog(
                  context: context,
                  builder: (c2) => AlertDialog(
                    backgroundColor: context.bg,
                    title: Text(
                      'Перезаписать?',
                      style: TextStyle(color: context.textMain),
                    ),
                    content: Text(
                      'Пресет "$name" уже существует. Заменить его?',
                      style: TextStyle(color: context.textMuted),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(c2);
                        },
                        child: Text(
                          'Отмена',
                          style: TextStyle(color: context.textMuted),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.primary,
                        ),
                        onPressed: () {
                          final newP = ViewPreset(
                            name: name,
                            columns: tempCols.map((x) => x.clone()).toList(),
                            filters:
                                tempFilters.map((x) => x.clone()).toList(),
                            sortColumn: tempSortColumn,
                            isAscending: tempIsAscending,
                          );
                          final list =
                              List<ViewPreset>.from(gridState.presets.value);
                          list[existingIdx] = newP;
                          gridState.presets.value = list;
                          gridState.currentViewName.value = name;
                          gridState.isViewModified.value = false;
                          Navigator.pop(c2);
                          Navigator.pop(c);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Да',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                final newP = ViewPreset(
                  name: name,
                  columns: tempCols.map((x) => x.clone()).toList(),
                  filters: tempFilters.map((x) => x.clone()).toList(),
                  sortColumn: tempSortColumn,
                  isAscending: tempIsAscending,
                );
                gridState.presets.value = [
                  ...gridState.presets.value,
                  newP,
                ];
                gridState.currentViewName.value = name;
                gridState.isViewModified.value = false;
                Navigator.pop(c);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: context.primary),
            child: const Text(
              'Сохранить',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activePresetObj = gridState.presets.value.firstWhere(
      (p) => p.name == currentPreset,
      orElse: () => gridState.presets.value.first,
    );

    return Dialog(
      backgroundColor: context.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 850,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: DialogScrollWrapper(
          minWidth: 700,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: DefaultTabController(
              length: 3,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Настройка представления',
                        style: TextStyle(
                          color: context.textMain,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: context.textMuted),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.border),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Активный пресет:',
                          style: TextStyle(
                            color: context.textMuted,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: context.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: currentPreset,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: context.textMuted,
                                  size: 16,
                                ),
                                dropdownColor: context.card,
                                borderRadius: BorderRadius.circular(12),
                                style: TextStyle(
                                  color: isModified
                                      ? context.orange
                                      : context.textMain,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                                isExpanded: true,
                                items: gridState.presets.value
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.name,
                                        child: Text(
                                          e.name +
                                              (isModified &&
                                                      e.name == currentPreset
                                                  ? ' *'
                                                  : ''),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) {
                                  if (v != null) {
                                    final preset = gridState.presets.value
                                        .firstWhere((p) => p.name == v);
                                    _applyPreset(preset);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        if (!activePresetObj.isStandard && !isModified) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: context.textMuted,
                              size: 20,
                            ),
                            onPressed: () => _renamePreset(currentPreset),
                            tooltip: 'Переименовать',
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                            onPressed: () => _deletePreset(currentPreset),
                            tooltip: 'Удалить',
                          ),
                        ],
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: isModified ? _saveAsNewPreset : null,
                          icon: const Icon(Icons.save, size: 16),
                          label: const Text('Сохранить'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: context.surface,
                            foregroundColor: context.textMain,
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TabBar(
                    dividerColor: context.border,
                    indicatorColor: context.primary,
                    labelColor: context.primary,
                    unselectedLabelColor: context.textMuted,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.view_column_outlined),
                        text: 'Структура колонок',
                      ),
                      Tab(
                        icon: Icon(Icons.filter_alt_outlined),
                        text: 'Условия фильтрации',
                      ),
                      Tab(
                        icon: Icon(Icons.sort_outlined),
                        text: 'Сортировка',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Включайте нужные колонки и меняйте их порядок перетаскиванием.',
                              style: TextStyle(
                                color: context.textMuted,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: ReorderableListView(
                                buildDefaultDragHandles: false,
                                onReorder: (oldIdx, newIdx) {
                                  _markAsModified();
                                  setState(() {
                                    if (newIdx > oldIdx) {
                                      newIdx -= 1;
                                    }
                                    final item = tempCols.removeAt(oldIdx);
                                    tempCols.insert(newIdx, item);
                                  });
                                },
                                children: tempCols
                                    .map(
                                      (c) => Container(
                                        key: ValueKey(c.key),
                                        margin: const EdgeInsets.only(
                                          bottom: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: context.card,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: context.border,
                                          ),
                                        ),
                                        child: ListTile(
                                          leading: ReorderableDragStartListener(
                                            index: tempCols.indexOf(c),
                                            child: Icon(
                                              Icons.drag_indicator,
                                              color: context.textMuted,
                                              size: 20,
                                            ),
                                          ),
                                          title: Text(
                                            c.title,
                                            style: TextStyle(
                                              color: context.textMain,
                                              fontSize: 14,
                                            ),
                                          ),
                                          trailing: CupertinoSwitch(
                                            value: c.isVisible,
                                            activeTrackColor: context.primary,
                                            onChanged: (v) {
                                              _markAsModified();
                                              setState(() {
                                                c.isVisible = v;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Фильтрация записей в таблице. Можно добавить несколько условий.',
                                  style: TextStyle(
                                    color: context.textMuted,
                                    fontSize: 13,
                                  ),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    _markAsModified();
                                    setState(() {
                                      tempFilters.add(FilterCondition());
                                    });
                                  },
                                  icon: const Icon(Icons.add, size: 16),
                                  label: const Text('Добавить условие'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (tempFilters.isEmpty)
                              Expanded(
                                child: Center(
                                  child: Text(
                                    'Нет активных фильтров',
                                    style:
                                        TextStyle(color: context.textMuted),
                                  ),
                                ),
                              ),
                            if (tempFilters.isNotEmpty)
                              Expanded(
                                child: ListView.builder(
                                  itemCount: tempFilters.length,
                                  itemBuilder: (context, idx) {
                                    final f = tempFilters[idx];
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: _buildFilterDropdown(
                                              f.field,
                                              gridState.defaultColumns
                                                  .map(
                                                    (c) => DropdownMenuItem(
                                                      value: c.key,
                                                      child: Text(c.title),
                                                    ),
                                                  )
                                                  .toList(),
                                              (v) {
                                                _markAsModified();
                                                setState(() {
                                                  f.field = v!;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: _buildFilterDropdown(
                                              f.operator,
                                              [
                                                'Равно',
                                                'Не равно',
                                                'Содержит',
                                                'Начинается с',
                                                'В списке',
                                              ]
                                                  .map(
                                                    (o) => DropdownMenuItem(
                                                      value: o,
                                                      child: Text(o),
                                                    ),
                                                  )
                                                  .toList(),
                                              (v) {
                                                _markAsModified();
                                                setState(() {
                                                  f.operator = v!;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              key: ValueKey(
                                                '${f.field}_${f.operator}',
                                              ),
                                              initialValue: f.value,
                                              style: TextStyle(
                                                color: context.textMain,
                                                fontSize: 13,
                                              ),
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: context.card,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  borderSide: BorderSide.none,
                                                ),
                                                hintText:
                                                    f.operator == 'В списке'
                                                    ? 'Например: В отпуске, Больничный'
                                                    : 'Значение',
                                                hintStyle: TextStyle(
                                                  color: context.textMuted
                                                      .withValues(alpha: 0.5),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                    ),
                                              ),
                                              onChanged: (v) {
                                                _markAsModified();
                                                f.value = v;
                                              },
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              _markAsModified();
                                              setState(() {
                                                tempFilters.removeAt(idx);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Колонка и направление сортировки для таблицы.',
                              style: TextStyle(
                                color: context.textMuted,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SizedBox(
                                  width: 280,
                                  child: _buildSortColumnDropdown(),
                                ),
                                const SizedBox(width: 16),
                                SegmentedButton<bool>(
                                  segments: const [
                                    ButtonSegment(
                                      value: true,
                                      label: Text('По возрастанию'),
                                      icon: Icon(Icons.arrow_upward, size: 16),
                                    ),
                                    ButtonSegment(
                                      value: false,
                                      label: Text('По убыванию'),
                                      icon: Icon(Icons.arrow_downward, size: 16),
                                    ),
                                  ],
                                  selected: {tempIsAscending},
                                  onSelectionChanged: (Set<bool> sel) {
                                    _markAsModified();
                                    setState(() {
                                      tempIsAscending = sel.first;
                                    });
                                  },
                                  style: ButtonStyle(
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          _applyPreset(activePresetObj);
                        },
                        child: const Text(
                          'Сбросить изменения',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Отмена',
                              style: TextStyle(color: context.textMuted),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              gridState.currentViewName.value =
                                  currentPreset;
                              gridState.isViewModified.value = isModified;
                              gridState.columns.value =
                                  List.from(tempCols);
                              gridState.filters.value =
                                  List.from(tempFilters);
                              gridState.sortColumn.value = tempSortColumn;
                              gridState.isAscending.value = tempIsAscending;
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Применить вид'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSortColumnDropdown() {
    const noSortKey = '__none__';
    final value = tempSortColumn ?? noSortKey;
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: Icon(Icons.keyboard_arrow_down, color: context.textMuted),
          dropdownColor: context.card,
          borderRadius: BorderRadius.circular(12),
          elevation: 6,
          style: TextStyle(color: context.textMain, fontSize: 13),
          isExpanded: true,
          items: [
            const DropdownMenuItem(
              value: noSortKey,
              child: Text('Без сортировки'),
            ),
            ...gridState.defaultColumns.map(
              (c) => DropdownMenuItem(
                value: c.key,
                child: Text(c.title),
              ),
            ),
          ],
          onChanged: (v) {
            _markAsModified();
            setState(() {
              tempSortColumn = (v == null || v == noSortKey) ? null : v;
            });
          },
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(
    String val,
    List<DropdownMenuItem<String>> items,
    Function(String?) onChanged,
  ) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: val,
          icon: Icon(Icons.keyboard_arrow_down, color: context.textMuted),
          dropdownColor: context.card,
          borderRadius: BorderRadius.circular(12),
          elevation: 6,
          style: TextStyle(color: context.textMain, fontSize: 13),
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
