import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/formatters.dart';
import '../../core/grid_models.dart';
import '../../core/status_utils.dart';
import '../../layout/responsive_wrapper.dart';
import '../../ui/custom_colors.dart';
import '../../widgets/erp_data_grid.dart';
import '../../widgets/erp_list_filter_row.dart';
import '../../widgets/erp_list_toolbar.dart';
import '../../widgets/erp_popup_menu_item.dart';
import '../../widgets/view_settings_dialog.dart';
import 'shifts_absence_dialog.dart';
import 'shifts_constants.dart';
import 'shifts_inventory_dialog.dart';

// ============================================================================
// ЭКРАН КОМАНДА (ДАТАГРИД, ФИЛЬТРЫ, ПРЕСЕТЫ) — ViewSettingsDialog в widgets/view_settings_dialog.dart
// ============================================================================

class ShiftsView extends StatefulWidget {
  const ShiftsView({super.key});
  @override
  State<ShiftsView> createState() => _ShiftsViewState();
}

class _ShiftsViewState extends State<ShiftsView> {
  String _searchQuery = '';
  String _filterZone = 'Все зоны';
  String _filterStatus = 'Все';
  String _filterRole = 'Все должности';
  String _filterEmployment = 'Все типы';
  final TextEditingController _searchCtrl = TextEditingController();

  final ScrollController _tableScrollController = ScrollController();
  final ScrollController _cardsScrollController = ScrollController();

  late final GridState _gridState = GridState(defaultColumns: defaultColumns);

  final List<Map<String, dynamic>> employees = [
    {
      'name': 'Алексей Смирнов',
      'login': 'smirnov_a',
      'role': 'Старший смены',
      'zone': 'Все зоны',
      'status': 'Активен',
      'hasAvatar': true,
      'phone': '+7 (701) 123-45-67',
      'telegram': 'alex_smirnov',
      'email': 'smirnov_a@sklad.kz',
      'hireDate': '12.08.2023',
      'contract': '№ 45-K',
      'iin': '900101300000',
      'clothes': 'L (48-50)',
      'shoes': '43',
      'locker': '112',
      'employment': 'Штат',
      'tsdPin': '1234',
      'absence': null,
      'rights': <String>['1C Предприятие', 'Редактирование смен'],
      'inventory': <Map<String, dynamic>>[
        {
          'name': 'Сканер Honeywell',
          'type': 'ТСД Сканер',
          'details': 'Инв. №4402',
          'condition': 'Новое',
          'status': 'Выдано',
          'issueDate': '15.02.2026, 10:30',
          'purpose': 'Для сборки',
        },
      ],
      'languages': <Map<String, String>>[
        {
          'name': 'Английский',
          'writing': 'Слабо',
          'speaking': 'Хорошо',
          'understanding': 'Отлично',
        },
      ],
    },
    {
      'name': 'Мария Иванова',
      'login': 'ivanova_m',
      'role': 'Комплектовщик',
      'zone': 'Зона А (Сборка)',
      'status': 'В отпуске',
      'hasAvatar': false,
      'phone': '+7 (702) 234-56-78',
      'telegram': 'maria_iv',
      'email': 'ivanova_m@sklad.kz',
      'hireDate': '05.01.2024',
      'contract': '№ 89-K',
      'iin': '950202400000',
      'clothes': 'S (44-46)',
      'shoes': '40',
      'locker': '045',
      'employment': 'Аутстаффинг',
      'tsdPin': '8832',
      'absence': '20.02.2026 - 28.02.2026',
      'rights': <String>['ТСД Сканер (Сборка)'],
      'inventory': <Map<String, dynamic>>[],
      'languages': <Map<String, String>>[],
    },
    {
      'name': 'Тимур Каримов',
      'login': 'karimov_t',
      'role': 'Водитель погрузчика',
      'zone': 'Пандус 1',
      'status': 'Активен',
      'hasAvatar': false,
      'phone': '+7 (777) 111-22-33',
      'telegram': 'tim_karim',
      'email': 'karimov_t@sklad.kz',
      'hireDate': '10.11.2022',
      'contract': '№ 12-K',
      'iin': '880505300111',
      'clothes': 'XL (50-52)',
      'shoes': '44',
      'locker': '089',
      'employment': 'Штат',
      'tsdPin': '5544',
      'absence': null,
      'rights': <String>['Вождение погрузчика'],
      'inventory': <Map<String, dynamic>>[],
      'languages': <Map<String, String>>[],
    },
    {
      'name': 'Елена Попова',
      'login': 'popova_e',
      'role': 'Приемщик',
      'zone': 'Пандус 1',
      'status': 'Больничный',
      'hasAvatar': true,
      'phone': '+7 (705) 555-44-33',
      'telegram': 'elena_p',
      'email': 'popova_e@sklad.kz',
      'hireDate': '01.03.2025',
      'contract': '№ 105-K',
      'iin': '920808400222',
      'clothes': 'M (46-48)',
      'shoes': '38',
      'locker': '012',
      'employment': 'Штат',
      'tsdPin': '1122',
      'absence': '22.02.2026 - 26.02.2026',
      'rights': <String>['ТСД Сканер (Приемка)'],
      'inventory': <Map<String, dynamic>>[],
      'languages': <Map<String, String>>[],
    },
    {
      'name': 'Денис Волков',
      'login': 'volkov_d',
      'role': 'Комплектовщик',
      'zone': 'Зона Б (Паллеты)',
      'status': 'Отсутствует',
      'hasAvatar': false,
      'phone': '+7 (708) 999-88-77',
      'telegram': 'denis_v',
      'email': 'volkov_d@sklad.kz',
      'hireDate': '15.09.2025',
      'contract': '№ 150-K',
      'iin': '980101300333',
      'clothes': 'L (48-50)',
      'shoes': '42',
      'locker': '156',
      'employment': 'ГПХ',
      'tsdPin': '9988',
      'absence': 'Невыход на смену',
      'rights': <String>['ТСД Сканер (Сборка)'],
      'inventory': <Map<String, dynamic>>[],
      'languages': <Map<String, String>>[],
    },
    {
      'name': 'Айдос Нурланов',
      'login': 'nurlanov_a',
      'role': 'Комплектовщик',
      'zone': 'Холодильник',
      'status': 'Активен',
      'hasAvatar': false,
      'phone': '+7 (701) 333-22-11',
      'telegram': 'aidos_n',
      'email': 'nurlanov_a@sklad.kz',
      'hireDate': '20.01.2026',
      'contract': '№ 201-K',
      'iin': '010203300444',
      'clothes': 'M (46-48)',
      'shoes': '41',
      'locker': '077',
      'employment': 'Аутстаффинг',
      'tsdPin': '3344',
      'absence': null,
      'rights': <String>['ТСД Сканер (Сборка)', 'Допуск в Холодильник'],
      'inventory': <Map<String, dynamic>>[],
      'languages': <Map<String, String>>[],
    },
    {
      'name': 'Светлана Ким',
      'login': 'kim_s',
      'role': 'Старший смены',
      'zone': 'Все зоны',
      'status': 'В архиве',
      'hasAvatar': true,
      'phone': '+7 (702) 444-55-66',
      'telegram': 'sveta_k',
      'email': 'kim_s@sklad.kz',
      'hireDate': '10.05.2021',
      'contract': '№ 05-K',
      'iin': '850606400555',
      'clothes': 'S (44-46)',
      'shoes': '37',
      'locker': '',
      'employment': 'Штат',
      'tsdPin': '',
      'absence': null,
      'rights': <String>[],
      'inventory': <Map<String, dynamic>>[],
      'languages': <Map<String, String>>[],
    },
    {
      'name': 'Игорь Тарасов',
      'login': 'tarasov_i',
      'role': 'Водитель погрузчика',
      'zone': 'Зона Б (Паллеты)',
      'status': 'Активен',
      'hasAvatar': false,
      'phone': '+7 (777) 666-77-88',
      'telegram': 'igor_t',
      'email': 'tarasov_i@sklad.kz',
      'hireDate': '05.12.2024',
      'contract': '№ 99-K',
      'iin': '940303300666',
      'clothes': 'XXL (52-54)',
      'shoes': '45',
      'locker': '190',
      'employment': 'Штат',
      'tsdPin': '7766',
      'absence': null,
      'rights': <String>['Вождение погрузчика'],
      'inventory': <Map<String, dynamic>>[],
      'languages': <Map<String, String>>[],
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchCtrl.text = _searchQuery;
  }

  @override
  void dispose() {
    _gridState.dispose();
    _searchCtrl.dispose();
    _tableScrollController.dispose();
    _cardsScrollController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredEmployees {
    var list = employees.where((emp) {
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        if (!emp['name'].toString().toLowerCase().contains(q) &&
            !emp['phone'].toString().contains(q)) {
          return false;
        }
      }
      if (_filterZone != 'Все зоны' && emp['zone'] != _filterZone) {
        return false;
      }
      if (_filterStatus != 'Все' && emp['status'] != _filterStatus) {
        return false;
      }
      if (_filterRole != 'Все должности' && emp['role'] != _filterRole) {
        return false;
      }
      if (_filterEmployment != 'Все типы' &&
          emp['employment'] != _filterEmployment) {
        return false;
      }

      // ЛОГИКА ФИЛЬТРАЦИИ AXELOT
      for (var f in _gridState.filters.value) {
        if (f.value.isEmpty) {
          continue;
        }
        var fieldVal = emp[f.field]?.toString().toLowerCase() ?? '';
        var searchVal = f.value.toLowerCase();

        if (f.operator == 'Равно' && fieldVal != searchVal) {
          return false;
        }
        if (f.operator == 'Не равно' && fieldVal == searchVal) {
          return false;
        }
        if (f.operator == 'Содержит' && !fieldVal.contains(searchVal)) {
          return false;
        }
        if (f.operator == 'Начинается с' && !fieldVal.startsWith(searchVal)) {
          return false;
        }
        if (f.operator == 'В списке') {
          final listValues = searchVal.split(',').map((e) => e.trim()).toList();
          if (!listValues.contains(fieldVal)) {
            return false;
          }
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
      _filterZone = 'Все зоны';
      _filterStatus = 'Все';
      _filterRole = 'Все должности';
      _filterEmployment = 'Все типы';
    });
  }

  void _showAddEmployeeModal() async {
    try {
      final newEmployee = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (context) => const EmployeeFormDialog(),
      );
      if (!mounted) return;
      if (newEmployee != null) {
        setState(() {
          employees.insert(0, newEmployee);
        });
      }
    } catch (e, _) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при открытии формы: $e')),
        );
      }
    }
  }

  void _showEditEmployeeModal(
    int index,
    Map<String, dynamic> emp, {
    bool reopenProfile = false,
  }) async {
    try {
      final updatedEmployee = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (context) => EmployeeFormDialog(employeeToEdit: emp),
      );
      if (!mounted) return;
      if (updatedEmployee != null) {
        setState(() {
          employees[index] = updatedEmployee;
        });
        if (reopenProfile) {
          _showEmployeeProfile(index, employees[index]);
        }
      }
    } catch (e, _) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при сохранении: $e')),
        );
      }
    }
  }

  void _showEmployeeProfile(int index, Map<String, dynamic> emp) {
    showDialog(
      context: context,
      builder: (context) => EmployeeProfileDialog(
        employee: emp,
        onEditTap: () {
          Navigator.pop(context);
          _showEditEmployeeModal(index, employees[index], reopenProfile: true);
        },
        onInventoryUpdated: () {
          setState(() {});
        },
      ),
    );
  }

  void _archiveEmployee(int index) {
    setState(() {
      employees[index]['status'] = 'В архиве';
    });
  }

  Widget _buildDashboardCard(
    String title,
    String value,
    Color color,
    IconData icon, [
    String? sub,
  ]) {
    return Container(
      width: 190,
      height: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: context.textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 18, color: color),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: context.textMain,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (sub != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    sub,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FilterCondition>>(
      valueListenable: _gridState.filters,
      builder: (context, _, child) {
        if (child != null) {}
        final currentList = filteredEmployees;

        int active = employees.where((e) => e['status'] == 'Активен').length;
        int vac = employees.where((e) => e['status'] == 'В отпуске').length;
        int sick = employees.where((e) => e['status'] == 'Больничный').length;
        int abs = employees.where((e) => e['status'] == 'Отсутствует').length;

        return Container(
          padding: const EdgeInsets.all(32.0),
          color: context.bg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ErpListToolbar(
                title: 'Команда компании',
                titleIcon: Icons.groups_outlined,
              ),
              const SizedBox(height: 24),

              LayoutBuilder(
                builder: (context, constraints) {
                  final behavior = ScrollConfiguration.of(
                    context,
                  ).copyWith(scrollbars: false);
                  const double minWidth =
                      1212; // 6 карточек * (190 + 12 margin)
                  final double w = constraints.maxWidth < minWidth
                      ? minWidth
                      : constraints.maxWidth;
                  return ScrollConfiguration(
                    behavior: behavior,
                    child: SingleChildScrollView(
                      controller: _cardsScrollController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: w,
                        child: Row(
                          children: [
                            _buildDashboardCard(
                              'Всего в штате',
                              '${employees.length}',
                              Colors.blueAccent,
                              Icons.groups_outlined,
                              '+2 за месяц',
                            ),
                            _buildDashboardCard(
                              'Активны на смене',
                              '$active',
                              Colors.greenAccent,
                              Icons.check_circle_outline,
                              '85% от цели',
                            ),
                            _buildDashboardCard(
                              'В отпуске',
                              '$vac',
                              Colors.orangeAccent,
                              Icons.beach_access_outlined,
                            ),
                            _buildDashboardCard(
                              'Больничный',
                              '$sick',
                              Colors.redAccent,
                              Icons.medical_services_outlined,
                            ),
                            _buildDashboardCard(
                              'Отсутствуют',
                              '$abs',
                              Colors.purpleAccent,
                              Icons.person_off_outlined,
                            ),
                            _buildDashboardCard(
                              'Эффективность',
                              '92%',
                              Colors.pinkAccent,
                              Icons.trending_up,
                              'Высокая',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
                        final contentWidth = tableWidth > constraints.maxWidth
                            ? tableWidth
                            : constraints.maxWidth;
                        return SingleChildScrollView(
                          controller: _tableScrollController,
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: contentWidth,
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
                                          quickFilters: [
                                            _buildCompactFilter(
                                              _filterZone,
                                              [
                                                'Все зоны',
                                                ...globalZones.where(
                                                  (z) => z != 'Все зоны',
                                                ),
                                              ],
                                              (v) {
                                                setState(() {
                                                  _filterZone = v!;
                                                });
                                              },
                                            ),
                                            _buildCompactFilter(
                                              _filterRole,
                                              ['Все должности', ...globalRoles],
                                              (v) {
                                                setState(() {
                                                  _filterRole = v!;
                                                });
                                              },
                                            ),
                                            _buildCompactFilter(
                                              _filterEmployment,
                                              ['Все типы', ...globalEmploymentTypes],
                                              (v) {
                                                setState(() {
                                                  _filterEmployment = v!;
                                                });
                                              },
                                            ),
                                            _buildCompactFilter(
                                              _filterStatus,
                                              ['Все', ...globalStatuses],
                                              (v) {
                                                setState(() {
                                                  _filterStatus = v!;
                                                });
                                              },
                                            ),
                                          ],
                                          onClearFilters: _clearFilters,
                                          onAddPressed: _showAddEmployeeModal,
                                          rowWidth: contentWidth,
                                          onSettingsPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (c) => ViewSettingsDialog(
                                                  gridState: _gridState),
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
                                    items: currentList,
                                    columns: visibleCols,
                                    cellBuilder: (context, item, col, index) =>
                                        _buildEmployeeCell(context, item, col, index),
                                    onRowTap: (item, index) {
                                      final originalIndex = employees.indexOf(item);
                                      _showEmployeeProfile(originalIndex, item);
                                    },
                                    horizontalScrollController: _tableScrollController,
                                    menuBuilder: (item) => [
                                      erpPopupMenuItem(
                                        context,
                                        value: 'profile',
                                        icon: Icons.person,
                                        label: 'Профиль',
                                      ),
                                      erpPopupMenuItem(
                                        context,
                                        value: 'edit',
                                        icon: Icons.edit,
                                        label: 'Редактировать',
                                      ),
                                      erpPopupMenuItem(
                                        context,
                                        value: 'archive',
                                        icon: Icons.archive,
                                        label: 'В архив',
                                        isDestructive: true,
                                      ),
                                    ],
                                    onMenuSelect: (value, item, index) {
                                      final originalIndex = employees.indexOf(item);
                                      if (value == 'profile') {
                                        _showEmployeeProfile(originalIndex, item);
                                      }
                                      if (value == 'edit') {
                                        _showEditEmployeeModal(originalIndex, item);
                                      }
                                      if (value == 'archive') {
                                        _archiveEmployee(originalIndex);
                                      }
                                    },
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
      },
    );
  }

  Widget _buildEmployeeCell(
    BuildContext context,
    Map<String, dynamic> item,
    ColumnConfig c,
    int index,
  ) {
    final originalIndex = employees.indexOf(item);
    final isArchived = item['status'] == 'В архиве';

    if (c.key == 'name') {
      return Row(
        children: [
          CircleAvatar(
            backgroundColor: context.border,
            child: item['hasAvatar'] == true
                ? const Icon(Icons.person, color: Colors.white70)
                : Text(
                    item['name'][0],
                    style: TextStyle(
                      color: context.textMain,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              item['name'],
              style: TextStyle(
                color: isArchived ? context.textMuted : context.textMain,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }
    if (c.key == 'phone') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          item['phone'] ?? 'Нет',
          style: TextStyle(color: context.textMuted, fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    if (c.key == 'employment') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          item['employment'] ?? 'Не указан',
          style: TextStyle(color: context.textMuted, fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    if (c.key == 'role') {
      return Align(
        alignment: Alignment.centerLeft,
        child: Text(
          item['role'],
          style: TextStyle(
            color: isArchived ? context.textMuted : context.textMain,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    if (c.key == 'zone') {
      if (isArchived) {
        return Text(
          item['zone'],
          style: TextStyle(color: context.textMuted),
          overflow: TextOverflow.ellipsis,
        );
      }
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.only(right: 8),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: item['zone'],
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: context.textMuted,
                size: 16,
              ),
              style: TextStyle(color: context.textMain, fontSize: 13),
              dropdownColor: context.card,
              borderRadius: BorderRadius.circular(12),
              elevation: 6,
              isDense: true,
              onChanged: (newZone) {
                setState(() {
                  employees[originalIndex]['zone'] = newZone!;
                });
              },
              items: globalZones
                  .map(
                    (z) => DropdownMenuItem(
                      value: z,
                      child: Text(z, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    }
    if (c.key == 'status') {
      final statusColor = getStatusColor(context, item['status']);
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: item['status'],
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: statusColor,
                size: 16,
              ),
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              dropdownColor: context.card,
              borderRadius: BorderRadius.circular(12),
              elevation: 6,
              isDense: true,
              onChanged: (newStatus) async {
                if (newStatus == 'В отпуске' ||
                    newStatus == 'Больничный' ||
                    newStatus == 'Отсутствует') {
                  final period = await showDialog<String>(
                    context: context,
                    builder: (c) => const AbsenceDialog(),
                  );
                  if (period != null) {
                    setState(() {
                      employees[originalIndex]['status'] = newStatus!;
                      employees[originalIndex]['absence'] = period;
                    });
                  }
                } else {
                  setState(() {
                    employees[originalIndex]['status'] = newStatus!;
                    employees[originalIndex]['absence'] = null;
                  });
                }
              },
              items: globalStatuses
                  .map(
                    (s) => DropdownMenuItem(
                      value: s,
                      child: Text(
                        s,
                        style: TextStyle(color: getStatusColor(context, s)),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        item[c.key]?.toString() ?? '-',
        style: TextStyle(
          color: isArchived ? context.textMuted : context.textMain,
          fontSize: 13,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCompactFilter(
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: context.bg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: context.textMuted,
            size: 18,
          ),
          dropdownColor: context.card,
          borderRadius: BorderRadius.circular(12),
          elevation: 6,
          style: TextStyle(color: context.textMain, fontSize: 12),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class EmployeeFormDialog extends StatefulWidget {
  final Map<String, dynamic>? employeeToEdit;
  const EmployeeFormDialog({super.key, this.employeeToEdit});

  @override
  State<EmployeeFormDialog> createState() => _EmployeeFormDialogState();
}

class _EmployeeFormDialogState extends State<EmployeeFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl,
      _loginCtrl,
      _phoneCtrl,
      _tgCtrl,
      _emailCtrl,
      _hireDateCtrl,
      _contractCtrl,
      _iinCtrl,
      _lockerCtrl,
      _tsdPinCtrl;
  late String _role, _zone, _status, _clothes, _shoes, _employment;
  late List<String> _selectedRights;
  late List<Map<String, String>> _languages;
  String? _absencePeriod;
  bool _hasAvatar = false;

  @override
  void initState() {
    super.initState();
    final e = widget.employeeToEdit;
    _nameCtrl = TextEditingController(text: e?['name'] ?? '');
    _loginCtrl = TextEditingController(text: e?['login'] ?? '');
    _phoneCtrl = TextEditingController(text: e?['phone'] ?? '');
    _tgCtrl = TextEditingController(text: e?['telegram'] ?? '');
    _emailCtrl = TextEditingController(text: e?['email'] ?? '');
    _hireDateCtrl = TextEditingController(text: e?['hireDate'] ?? '');
    _contractCtrl = TextEditingController(text: e?['contract'] ?? '');
    _iinCtrl = TextEditingController(text: e?['iin'] ?? '');
    _lockerCtrl = TextEditingController(text: e?['locker'] ?? '');
    _tsdPinCtrl = TextEditingController(text: e?['tsdPin'] ?? '');
    _absencePeriod = e?['absence'];
    _hasAvatar = e?['hasAvatar'] ?? false;

    _selectedRights = List<String>.from(e?['rights'] ?? []);
    _languages = List<Map<String, String>>.from(e?['languages'] ?? []);

    _role = e?['role'] ?? globalRoles[0];
    _zone = e?['zone'] ?? globalZones[0];
    _status = e?['status'] ?? globalStatuses[0];
    if (!globalStatuses.contains(_status)) {
      _status = globalStatuses[0];
    }

    _clothes = e?['clothes'] ?? clothesSizes[2];
    _shoes = e?['shoes'] ?? shoeSizes[5];
    _employment = e?['employment'] ?? globalEmploymentTypes[0];
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _loginCtrl.dispose();
    _phoneCtrl.dispose();
    _tgCtrl.dispose();
    _emailCtrl.dispose();
    _hireDateCtrl.dispose();
    _contractCtrl.dispose();
    _iinCtrl.dispose();
    _lockerCtrl.dispose();
    _tsdPinCtrl.dispose();
    super.dispose();
  }

  void _onNameChanged(String name) {
    if (widget.employeeToEdit != null) {
      return;
    }
    String latin = transliterate(name.trim());
    List<String> parts = latin.split(RegExp(r'\s+'));
    String login = '';
    if (parts.isNotEmpty && parts[0].isNotEmpty) {
      login = parts[0].toLowerCase();
      if (parts.length > 1 && parts[1].isNotEmpty) {
        login += '_${parts[1][0].toLowerCase()}';
      }
    }
    _loginCtrl.value = TextEditingValue(
      text: login,
      selection: TextSelection.collapsed(offset: login.length),
    );
    final email = login.isNotEmpty ? '$login@sklad.kz' : '';
    _emailCtrl.value = TextEditingValue(
      text: email,
      selection: TextSelection.collapsed(offset: email.length),
    );
  }

  Future<void> _pickAbsenceDateRange() async {
    try {
      final period = await showDialog<String>(
        context: context,
        builder: (c) => const AbsenceDialog(),
      );
      if (period != null && mounted) {
        setState(() {
          _absencePeriod = period;
        });
      }
    } catch (e, _) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при выборе периода: $e')),
        );
      }
    }
  }

  void _pickDate() async {
    try {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: context.primary,
              onPrimary: Colors.white,
              surface: context.card,
              onSurface: context.textMain,
            ),
          ),
          child: child!,
        ),
      );
      if (picked != null && mounted) {
        _hireDateCtrl.text =
            "${picked.day.toString().padLeft(2, '0')}.${picked.month.toString().padLeft(2, '0')}.${picked.year}";
      }
    } catch (e, _) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось выбрать дату: $e')),
        );
      }
    }
  }

  void _addLanguage() async {
    try {
      final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        const availableLanguages = [
          'Английский',
          'Казахский',
          'Русский',
          'Китайский',
          'Узбекский',
        ];
        final usedNames = _languages
            .map((l) => l['name'])
            .whereType<String>()
            .toSet();
        String lang = availableLanguages.firstWhere(
          (l) => !usedNames.contains(l),
          orElse: () => availableLanguages.first,
        );
        String write = 'Хорошо';
        String speak = 'Хорошо';
        String understand = 'Хорошо';
        final levels = ['Слабо', 'Хорошо', 'Отлично', 'Родной'];

        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              backgroundColor: context.bg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                'Добавить язык',
                style: TextStyle(
                  color: context.textMain,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: 320,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Язык',
                      style: TextStyle(
                        color: context.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: lang,
                        dropdownColor: context.card,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 6,
                        style: TextStyle(color: context.textMain),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: context.textMuted,
                        ),
                        items: availableLanguages
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          setStateSB(() {
                            lang = v!;
                          });
                        },
                      ),
                    ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Письменная речь',
                      style: TextStyle(
                        color: context.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: write,
                        dropdownColor: context.card,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 6,
                        style: TextStyle(color: context.textMain),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: context.textMuted,
                        ),
                        items: levels
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) {
                          setStateSB(() {
                            write = v!;
                          });
                        },
                      ),
                    ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Устная речь',
                      style: TextStyle(
                        color: context.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: speak,
                        dropdownColor: context.card,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 6,
                        style: TextStyle(color: context.textMain),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: context.textMuted,
                        ),
                        items: levels
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) {
                          setStateSB(() {
                            speak = v!;
                          });
                        },
                      ),
                    ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Понимание',
                      style: TextStyle(
                        color: context.textMuted,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: understand,
                        dropdownColor: context.card,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 6,
                        style: TextStyle(color: context.textMain),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: context.textMuted,
                        ),
                        items: levels
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) {
                          setStateSB(() {
                            understand = v!;
                          });
                        },
                      ),
                    ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Отмена',
                    style: TextStyle(color: context.textMuted),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'name': lang,
                      'writing': write,
                      'speaking': speak,
                      'understanding': understand,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Добавить',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (result != null && mounted) {
      setState(() {
        // Если язык уже есть в списке, просто обновим уровни, а не будем дублировать строку.
        final existingIndex = _languages.indexWhere(
          (l) => l['name'] == result['name'],
        );
        if (existingIndex != -1) {
          _languages[existingIndex] = result;
        } else {
          _languages.add(result);
        }
        _languages.sort(
          (a, b) => (a['name'] ?? '').compareTo(b['name'] ?? ''),
        );
      });
    }
    } catch (e, _) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при добавлении языка: $e')),
        );
      }
    }
  }

  Widget _buildField(
    String label,
    TextEditingController ctrl, {
    bool isRequired = false,
    String hint = '',
    bool readOnly = false,
    VoidCallback? onTap,
    List<TextInputFormatter>? formatters,
    String? prefix,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 8),
          TextFormField(
            controller: ctrl,
            readOnly: readOnly,
            onTap: onTap,
            inputFormatters: formatters,
            style: TextStyle(
              color: readOnly ? context.textMuted : context.textMain,
            ),
            onChanged: ctrl == _nameCtrl ? _onNameChanged : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: context.card,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: context.textMuted.withValues(alpha: 0.3),
              ),
              prefixText: prefix,
              prefixStyle: TextStyle(color: context.textMain, fontSize: 15),
            ),
            validator: isRequired
                ? (v) {
                    if (v!.trim().isEmpty) return 'Обязательное поле';
                    return null;
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String val,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: context.textMuted, fontSize: 12)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                isExpanded: true,
                style: TextStyle(color: context.textMain),
                items: items
                    .map(
                      (i) => DropdownMenuItem(
                        value: i,
                        child: Text(i, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.employeeToEdit != null;

    return Dialog(
      backgroundColor: context.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 950,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: DialogScrollWrapper(
          minWidth: 850,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isEditing ? 'Редактировать профиль' : 'Новый сотрудник',
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
                  Flexible(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: 880,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 410,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ОСНОВНАЯ ИНФОРМАЦИЯ',
                                    style: TextStyle(
                                      color: context.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _hasAvatar = !_hasAvatar;
                                          });
                                        },
                                        child: CircleAvatar(
                                          radius: 32,
                                          backgroundColor: context.border,
                                          child: _hasAvatar
                                              ? const Icon(
                                                  Icons.person,
                                                  size: 40,
                                                  color: Colors.white70,
                                                )
                                              : Icon(
                                                  Icons.add_a_photo,
                                                  size: 24,
                                                  color: context.textMuted,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: _buildField(
                                          'ФИО Сотрудника',
                                          _nameCtrl,
                                          isRequired: true,
                                          hint: 'Иванов Иван',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: _buildField(
                                          'Логин (Генерирует Email)',
                                          _loginCtrl,
                                          isRequired: true,
                                          hint: 'ivanov_i',
                                          formatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z0-9_]'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        flex: 2,
                                        child: _buildField(
                                          'ПИН ТСД',
                                          _tsdPinCtrl,
                                          hint: '0000',
                                          formatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildDropdown(
                                          'Должность',
                                          _role,
                                          globalRoles,
                                          (v) {
                                            setState(() {
                                              _role = v!;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: _buildDropdown(
                                          'Зона работы',
                                          _zone,
                                          globalZones,
                                          (v) {
                                            setState(() {
                                              _zone = v!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildDropdown(
                                          'Тип найма',
                                          _employment,
                                          globalEmploymentTypes,
                                          (v) {
                                            setState(() {
                                              _employment = v!;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 16.0,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Статус',
                                                style: TextStyle(
                                                  color: context.textMuted,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: context.card,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: DropdownButtonHideUnderline(
                                                  child: DropdownButton<String>(
                                                    value: _status,
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: context.textMuted,
                                                    ),
                                                    dropdownColor: context.card,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    elevation: 6,
                                                    isExpanded: true,
                                                    style: TextStyle(
                                                      color: context.textMain,
                                                    ),
                                                    items: globalStatuses
                                                        .map(
                                                          (
                                                            i,
                                                          ) => DropdownMenuItem(
                                                            value: i,
                                                            child: Text(
                                                              i,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        )
                                                        .toList(),
                                                    onChanged: (v) async {
                                                      if (v == 'В отпуске' ||
                                                          v == 'Больничный' ||
                                                          v == 'Отсутствует') {
                                                        await _pickAbsenceDateRange();
                                                        setState(() {
                                                          _status = v!;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          _status = v!;
                                                          _absencePeriod = null;
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_absencePeriod != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 16.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.date_range,
                                            color: context.textMuted,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Период: $_absencePeriod',
                                            style: TextStyle(
                                              color: context.orange,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          InkWell(
                                            onTap: _pickAbsenceDateRange,
                                            child: Text(
                                              'Изменить',
                                              style: TextStyle(
                                                color: context.primary,
                                                fontSize: 12,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  const SizedBox(height: 8),
                                  Text(
                                    'ЭКИПИРОВКА',
                                    style: TextStyle(
                                      color: context.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildDropdown(
                                          'Размер одежды',
                                          _clothes,
                                          clothesSizes,
                                          (v) {
                                            setState(() {
                                              _clothes = v!;
                                            });
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: _buildDropdown(
                                          'Размер обуви',
                                          _shoes,
                                          shoeSizes,
                                          (v) {
                                            setState(() {
                                              _shoes = v!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  _buildField(
                                    'Номер шкафчика',
                                    _lockerCtrl,
                                    hint: 'Например: 112',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 60),

                            SizedBox(
                              width: 410,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'КОНТАКТЫ И СВЯЗЬ',
                                    style: TextStyle(
                                      color: context.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildField(
                                    'Телефон',
                                    _phoneCtrl,
                                    hint: '+7 (XXX) XXX-XX-XX',
                                    formatters: [PhoneInputFormatter()],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildField(
                                          'Telegram',
                                          _tgCtrl,
                                          hint: 'nickname',
                                          prefix: '@',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: _buildField(
                                          'Корп. Email',
                                          _emailCtrl,
                                          readOnly: true,
                                          hint: 'Автоматически',
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  Text(
                                    'HR & ОФОРМЛЕНИЕ',
                                    style: TextStyle(
                                      color: context.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildField(
                                    'Дата приема на работу',
                                    _hireDateCtrl,
                                    hint: 'Выберите дату',
                                    readOnly: true,
                                    onTap: _pickDate,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildField(
                                          'Номер договора',
                                          _contractCtrl,
                                          hint: '№ договора',
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: _buildField(
                                          'ИИН',
                                          _iinCtrl,
                                          hint: '12 цифр',
                                          formatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(
                                              12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'ЗНАНИЕ ЯЗЫКОВ',
                                        style: TextStyle(
                                          color: context.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _addLanguage,
                                        child: Text(
                                          '+ Добавить',
                                          style: TextStyle(
                                            color: context.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  if (_languages.isEmpty)
                                    Text(
                                      'Языки не добавлены',
                                      style: TextStyle(
                                        color: context.textMuted,
                                        fontSize: 12,
                                      ),
                                    )
                                  else
                                    ..._languages.asMap().entries.map((entry) {
                                      int idx = entry.key;
                                      Map<String, String> lang = entry.value;
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: context.card,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: context.border,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                lang['name']!,
                                                style: TextStyle(
                                                  color: context.textMain,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${lang['writing']!} / ${lang['speaking']!} / ${lang['understanding']!}',
                                                    style: TextStyle(
                                                      color: context.textMuted,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        _languages.removeAt(
                                                          idx,
                                                        );
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 16,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  const SizedBox(height: 24),

                                  Text(
                                    'СИСТЕМНЫЕ ПРАВА',
                                    style: TextStyle(
                                      color: context.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: globalRights.map((right) {
                                      final isSelected = _selectedRights
                                          .contains(right);
                                      return FilterChip(
                                        label: Text(
                                          right,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : context.textMain,
                                            fontSize: 12,
                                          ),
                                        ),
                                        selected: isSelected,
                                        selectedColor: context.primary,
                                        backgroundColor: context.card,
                                        checkmarkColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          side: BorderSide.none,
                                        ),
                                        onSelected: (bool selected) {
                                          setState(() {
                                            if (selected) {
                                              _selectedRights.add(right);
                                            } else {
                                              _selectedRights.remove(right);
                                            }
                                          });
                                        },
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          String tg = _tgCtrl.text.trim();
                          if (tg.startsWith('@')) {
                            tg = tg.substring(1);
                          }

                          Navigator.pop(context, {
                            'name': _nameCtrl.text.trim(),
                            'login': _loginCtrl.text.trim(),
                            'phone': _phoneCtrl.text.trim(),
                            'telegram': tg,
                            'email': _emailCtrl.text.trim(),
                            'hireDate': _hireDateCtrl.text.trim(),
                            'contract': _contractCtrl.text.trim(),
                            'iin': _iinCtrl.text.trim(),
                            'locker': _lockerCtrl.text.trim(),
                            'tsdPin': _tsdPinCtrl.text.trim(),
                            'employment': _employment,
                            'rights': _selectedRights,
                            'role': _role,
                            'zone': _zone,
                            'status': _status,
                            'clothes': _clothes,
                            'shoes': _shoes,
                            'absence': _absencePeriod,
                            'hasAvatar': _hasAvatar,
                            'languages': _languages,
                            'inventory':
                                widget.employeeToEdit?['inventory'] ??
                                <Map<String, dynamic>>[],
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          isEditing ? 'Сохранить изменения' : 'Создать профиль',
                        ),
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
}

class EmployeeProfileDialog extends StatefulWidget {
  final Map<String, dynamic> employee;
  final VoidCallback onEditTap;
  final VoidCallback onInventoryUpdated;

  const EmployeeProfileDialog({
    super.key,
    required this.employee,
    required this.onEditTap,
    required this.onInventoryUpdated,
  });

  @override
  State<EmployeeProfileDialog> createState() => _EmployeeProfileDialogState();
}

class _EmployeeProfileDialogState extends State<EmployeeProfileDialog> {
  IconData _getInventoryIcon(String? type) {
    switch (type) {
      case 'Ноутбук / ПК':
        return Icons.laptop_mac;
      case 'ТСД Сканер':
        return Icons.qr_code_scanner;
      case 'Рация':
        return Icons.speaker_phone;
      case 'Спецодежда':
        return Icons.checkroom;
      case 'Ключи':
        return Icons.key;
      default:
        return Icons.inventory_2;
    }
  }

  void _showInventoryDialog({Map<String, dynamic>? item, int? index}) async {
    try {
      final result = await showDialog<Map<String, dynamic>>(
        context: context,
        builder: (c) => ShiftsInventoryDialog(item: item),
      );
      _applyInventoryResult(result, index);
    } catch (e, _) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при сохранении имущества: $e')),
        );
      }
    }
  }

  void _applyInventoryResult(Map<String, dynamic>? result, int? index) {
    if (result == null || result['name'].toString().trim().isEmpty || !mounted) return;
    setState(() {
      final now = DateTime.now();
      final dateStr =
          result['issueDate'] ??
          "${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}, ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

      final finalItem = <String, dynamic>{
        'name': result['name'].toString().trim(),
        'type': result['type'],
        'details': result['details'].toString().trim(),
        'purpose': result['purpose'].toString().trim(),
        'condition': result['condition'],
        'status': result['status'],
        'issueDate': dateStr,
      };

      if (index != null) {
        (widget.employee['inventory'] as List)[index] = finalItem;
      } else {
        (widget.employee['inventory'] as List).insert(0, finalItem);
      }
    });
    widget.onInventoryUpdated();
  }

  @override
  Widget build(BuildContext context) {
    final emp = widget.employee;
    final statusColor = getStatusColor(context, emp['status']);

    return Dialog(
      backgroundColor: context.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1200,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: DialogScrollWrapper(
          minWidth: 1050,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SizedBox(
              width: 1100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: DefaultTabController(
                      length: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: context.textMuted,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Профиль сотрудника',
                                    style: TextStyle(
                                      color: context.textMuted,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton.icon(
                                onPressed: widget.onEditTap,
                                icon: const Icon(Icons.edit, size: 14),
                                label: const Text(
                                  'Редактировать',
                                  style: TextStyle(fontSize: 13),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: context.primary,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          TabBar(
                            dividerColor: context.border,
                            indicatorColor: context.primary,
                            labelColor: context.primary,
                            unselectedLabelColor: context.textMuted,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            tabs: const [
                              Tab(text: 'Личное дело'),
                              Tab(text: 'Доступы и Права'),
                              Tab(text: 'Эффективность'),
                              Tab(text: 'Время и Отсутствия'),
                              Tab(text: 'Имущество'),
                              Tab(text: 'Хронология'),
                            ],
                          ),
                          SizedBox(
                            height: 600,
                            child: TabBarView(
                              children: [
                                _buildHRTab(emp),
                                _buildAccessTab(emp),
                                _buildEfficiencyTab(emp),
                                _buildTimeTab(emp),
                                _buildInventoryTab(emp),
                                _buildHistoryTab(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),

                  Container(
                    width: 340,
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: context.border),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 56,
                            backgroundColor: context.surface,
                            child: emp['hasAvatar'] == true
                                ? const Icon(
                                    Icons.person,
                                    size: 72,
                                    color: Colors.white70,
                                  )
                                : Text(
                                    emp['name'][0],
                                    style: TextStyle(
                                      color: context.textMain,
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            emp['name'],
                            style: TextStyle(
                              color: context.textMain,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            emp['role'],
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 14,
                            ),
                          ),

                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: context.border,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SelectableText(
                              '@${emp['login']}',
                              style: TextStyle(
                                color: context.textMuted,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          Container(
                            height: 32,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              border: Border.all(
                                color: statusColor.withValues(alpha: 0.3),
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                alignment: Alignment.center,
                                value: emp['status'],
                                icon: Padding(
                                  padding: const EdgeInsets.only(left: 6.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: statusColor,
                                    size: 16,
                                  ),
                                ),
                                style: TextStyle(
                                  color: statusColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                                dropdownColor: context.card,
                                borderRadius: BorderRadius.circular(12),
                                elevation: 6,
                                isDense: true,
                                onChanged: (newStatus) async {
                                  if (newStatus == 'В отпуске' ||
                                      newStatus == 'Больничный' ||
                                      newStatus == 'Отсутствует') {
                                    final period = await showDialog<String>(
                                      context: context,
                                      builder: (c) => const AbsenceDialog(),
                                    );
                                    if (period != null) {
                                      setState(() {
                                        emp['status'] = newStatus!;
                                        emp['absence'] = period;
                                      });
                                      widget.onInventoryUpdated();
                                    }
                                  } else {
                                    setState(() {
                                      emp['status'] = newStatus!;
                                      emp['absence'] = null;
                                    });
                                    widget.onInventoryUpdated();
                                  }
                                },
                                items: globalStatuses
                                    .map(
                                      (s) => DropdownMenuItem(
                                        value: s,
                                        child: Text(
                                          s,
                                          style: TextStyle(
                                            color: getStatusColor(context, s),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          _buildProfileRow(
                            Icons.email_outlined,
                            'Email',
                            _emptyTo(emp['email'], 'Не указан'),
                          ),
                          const SizedBox(height: 16),
                          _buildProfileRow(
                            Icons.phone_outlined,
                            'Телефон',
                            _emptyTo(emp['phone'], 'Не указан'),
                          ),
                          const SizedBox(height: 16),
                          _buildProfileRow(
                            Icons.telegram,
                            'Telegram',
                            emp['telegram']?.isNotEmpty == true
                                ? '@${emp['telegram']}'
                                : 'Не привязан',
                          ),
                          const SizedBox(height: 16),
                          _buildProfileRow(
                            Icons.location_on_outlined,
                            'Зона',
                            emp['zone'],
                          ),
                          const SizedBox(height: 16),
                          _buildProfileRow(
                            Icons.calendar_today_outlined,
                            'Прием на работу',
                            _emptyTo(emp['hireDate'], 'Не указана'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: context.textMuted),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(color: context.textMuted, fontSize: 11),
              ),
              const SizedBox(height: 4),
              SelectableText(
                value,
                style: TextStyle(
                  color: context.textMain,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactLanguages(List<dynamic>? languages) {
    if (languages == null || languages.isEmpty) {
      return Text(
        'Языки не добавлены',
        style: TextStyle(color: context.textMuted, fontSize: 13),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: languages.map((lang) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang['name'],
                style: TextStyle(
                  color: context.textMain,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildLangLevel('Письмо', lang['writing']),
                  _buildLangLevel('Говорение', lang['speaking']),
                  _buildLangLevel('Понимание', lang['understanding']),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLangLevel(String label, String level) {
    Color levelColor = context.textMuted;
    if (level == 'Отлично' || level == 'Родной') {
      levelColor = Colors.greenAccent;
    }
    if (level == 'Хорошо') {
      levelColor = context.primary;
    }
    if (level == 'Слабо') {
      levelColor = Colors.orangeAccent;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: context.textMuted, fontSize: 10)),
        const SizedBox(height: 4),
        Text(
          level,
          style: TextStyle(
            color: levelColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHRTab(Map<String, dynamic> emp) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24, bottom: 24, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildInfoCard('Кадровые данные', [
                  _buildDataRow(
                    Icons.badge,
                    'ИИН',
                    _emptyTo(emp['iin'], 'Нет данных'),
                  ),
                  _buildDataRow(
                    Icons.description,
                    'Номер договора',
                    _emptyTo(emp['contract'], 'Нет данных'),
                  ),
                  _buildDataRow(
                    Icons.work_outline,
                    'Тип найма',
                    _emptyTo(emp['employment'], 'Не указан'),
                  ),
                ]),
                const SizedBox(height: 24),
                _buildInfoCard('Владение языками', [
                  _buildCompactLanguages(emp['languages']),
                ]),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                _buildInfoCard('Складская Экипировка', [
                  _buildDataRow(
                    Icons.checkroom,
                    'Размер одежды',
                    _emptyTo(emp['clothes'], 'Не выдан'),
                  ),
                  _buildDataRow(
                    Icons.snowshoeing,
                    'Размер обуви',
                    _emptyTo(emp['shoes'], 'Не выдана'),
                  ),
                  _buildDataRow(
                    Icons.door_sliding,
                    'Шкафчик',
                    _emptyTo(emp['locker'], 'Не закреплен'),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _emptyTo(String? val, String fallback) {
    if (val == null || val.trim().isEmpty) {
      return fallback;
    }
    return val;
  }

  Widget _buildAccessTab(Map<String, dynamic> emp) {
    List<String> rights = List<String>.from(emp['rights'] ?? []);
    return ListView(
      padding: const EdgeInsets.only(top: 24, bottom: 24, right: 16),
      children: [
        _buildInfoCard('Авторизация в системах', [
          _buildDataRow(
            Icons.pin,
            'ПИН-код для ТСД',
            _emptyTo(emp['tsdPin'], 'Не задан'),
          ),
          _buildDataRow(Icons.login, 'Последний вход', 'Сегодня, 08:15 AM'),
        ]),
        const SizedBox(height: 24),
        _buildInfoCard('Выданные системные права', [
          rights.isEmpty
              ? Text(
                  'Нет выданных прав',
                  style: TextStyle(color: context.textMuted),
                )
              : Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: rights
                      .map(
                        (r) => Chip(
                          label: Text(r),
                          backgroundColor: context.border,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                      .toList(),
                ),
        ]),
      ],
    );
  }

  Widget _buildEfficiencyTab(Map<String, dynamic> emp) {
    return ListView(
      padding: const EdgeInsets.only(top: 24, bottom: 24, right: 16),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildInfoCard('Показатели KPI (Текущий месяц)', [
                _buildDataRow(Icons.speed, 'Скорость сборки', '124 строк/час'),
                _buildDataRow(Icons.task_alt, 'Ошибок сборки', '2 (0.1%)'),
              ]),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildInfoCard('Сводка', [
                _buildDataRow(
                  Icons.trending_up,
                  'Тренд',
                  'Положительный (+5%)',
                ),
                _buildDataRow(Icons.star_border, 'Рейтинг смены', '4.8 / 5.0'),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          height: 250,
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.border),
          ),
          child: Center(
            child: Text(
              'График производительности (в разработке)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeTab(Map<String, dynamic> emp) {
    return ListView(
      padding: const EdgeInsets.only(top: 24, bottom: 24, right: 16),
      children: [
        if (emp['absence'] != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.orange.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: context.orange),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Сотрудник отсутствует: ${emp['absence']}',
                      style: TextStyle(
                        color: context.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard('Баланс времени (Февраль)', [
                _buildDataRow(Icons.timer, 'Отработано', '144 часа'),
                _buildDataRow(Icons.calendar_today, 'Смен', '12 смен'),
              ]),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildInfoCard('Отпуска и Отгулы', [
                _buildDataRow(Icons.beach_access, 'Остаток отпуска', '14 дней'),
                _buildDataRow(
                  Icons.medical_services,
                  'Больничных в году',
                  '0 дней',
                ),
              ]),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // ИСПРАВЛЕНО: Интерактивный UI-блок графика смен вместо простого текста
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'График смен (Февраль)',
                    style: TextStyle(
                      color: context.textMain,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: context.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Смена',
                        style: TextStyle(
                          color: context.textMuted,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: context.surface,
                          shape: BoxShape.circle,
                          border: Border.all(color: context.border),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Выходной',
                        style: TextStyle(
                          color: context.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            'Пн',
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            'Вт',
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            'Ср',
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            'Чт',
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            'Пт',
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            'Сб',
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 36,
                        child: Center(
                          child: Text(
                            'Вс',
                            style: TextStyle(
                              color: context.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: List.generate(4, (week) {
                      return Padding(
                        padding: EdgeInsets.only(top: week == 0 ? 0 : 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(7, (weekday) {
                            final index = week * 7 + weekday;
                            final day = index + 1;
                            if (day > 28) {
                              return const SizedBox(width: 36, height: 36);
                            }
                            // Имитация графика 2/2
                            final isShift =
                                (index % 4 == 0) || (index % 4 == 1);
                            return Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: isShift
                                    ? context.primary
                                    : context.surface,
                                borderRadius: BorderRadius.circular(8),
                                border: isShift
                                    ? null
                                    : Border.all(color: context.border),
                              ),
                              child: Center(
                                child: Text(
                                  day.toString(),
                                  style: TextStyle(
                                    color: isShift
                                        ? Colors.white
                                        : context.textMain,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryTab(Map<String, dynamic> emp) {
    List<dynamic> inventory = emp['inventory'] ?? [];
    return ListView(
      padding: const EdgeInsets.only(top: 24, bottom: 24, right: 16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Физическое имущество на руках',
              style: TextStyle(
                color: context.textMain,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                _showInventoryDialog();
              },
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Выдать'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.border),
          ),
          child: inventory.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Имущество не выдано',
                    style: TextStyle(color: context.textMuted),
                  ),
                )
              : Column(
                  children: List.generate(inventory.length, (index) {
                    final item = inventory[index];
                    final isWithdrawn = item['status'] == 'Изъято';
                    final isRepair = item['status'] == 'На ремонте';

                    Color statusColor = Colors.greenAccent;
                    if (isWithdrawn) {
                      statusColor = Colors.grey;
                    }
                    if (isRepair) {
                      statusColor = Colors.orangeAccent;
                    }

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: context.border,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getInventoryIcon(item['type']),
                          color: isWithdrawn
                              ? context.textMuted
                              : context.textMain,
                          size: 24,
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            item['name'],
                            style: TextStyle(
                              color: isWithdrawn
                                  ? context.textMuted
                                  : context.textMain,
                              fontWeight: FontWeight.bold,
                              decoration: isWithdrawn
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              item['status'],
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${item['details']} • Состояние: ${item['condition'] ?? 'Не указано'}',
                              style: TextStyle(
                                color: context.textMuted,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Выдано: ${item['issueDate']} ${item['purpose']?.isNotEmpty == true ? '(${item['purpose']})' : ''}',
                              style: TextStyle(
                                color: context.textMuted.withValues(alpha: 0.6),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit, color: context.textMuted),
                        onPressed: () {
                          _showInventoryDialog(item: item, index: index);
                        },
                        tooltip: 'Редактировать статус/детали',
                      ),
                    );
                  }),
                ),
        ),
      ],
    );
  }

Widget _buildHistoryTab() {
    final history = [
      {
        'date': '20 Фев 2026, 08:00',
        'type': 'Смена статуса',
        'desc': 'Статус изменен на "Активен"',
      },
      {
        'date': '15 Фев 2026, 10:30',
        'type': 'Оборудование',
        'desc': 'Выдан ТСД Сканер (Инв. №4402)',
      },
      {
        'date': '10 Янв 2026, 14:00',
        'type': 'Инструктаж',
        'desc': 'Пройден инструктаж ТБ (Безопасный нож)',
      },
      {
        'date': '12 Авг 2024, 09:00',
        'type': 'Оформление',
        'desc': 'Сотрудник добавлен в систему',
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 24, bottom: 24, right: 16),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.border),
        ),
        child: DataTable(
          headingTextStyle: TextStyle(
            color: context.textMuted,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          dataTextStyle: TextStyle(color: context.textMain, fontSize: 14),
          dividerThickness: 1,
          columns: const [
            DataColumn(label: Text('ДАТА И ВРЕМЯ')),
            DataColumn(label: Text('СОБЫТИЕ')),
            DataColumn(label: Text('ОПИСАНИЕ')),
          ],
          rows: history
              .map(
                (h) => DataRow(
                  cells: [
                    DataCell(
                      Text(
                        h['date']!,
                        style: TextStyle(color: context.textMuted),
                      ),
                    ),
                    DataCell(
                      Text(
                        h['type']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(h['desc']!)),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    List<Widget> children, {
    double padding = 24.0,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: padding == 0 ? 24 : padding,
              left: 24,
              right: 24,
              bottom: 16,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: context.textMain,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: padding == 0 ? 0 : padding,
              right: padding == 0 ? 0 : padding,
              bottom: padding == 0 ? 0 : padding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: context.textMuted, size: 18),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(color: context.textMuted, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: SelectableText(
              value,
              style: TextStyle(
                color: context.textMain,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
