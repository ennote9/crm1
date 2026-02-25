import 'package:flutter/material.dart';

import '../app/settings_store.dart';
import '../core/status_utils.dart';
import '../ui/custom_colors.dart';
import '../features/dashboard/dashboard_view.dart';
import '../features/settings/settings_view.dart';
import '../features/shifts/shifts_view.dart';
import '../features/products/products_view.dart';
import '../features/sku/sku_view.dart';
import '../features/zones/zones_view.dart';
import 'responsive_wrapper.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 1;
  final ValueNotifier<bool> _isSidebarExpanded = ValueNotifier(false);

  final List<Widget> _screens = [
    const DashboardView(),
    const ShiftsView(),
    const ZonesView(),
    const ProductsView(),
    const SkusView(),
    const Center(child: Text('Аналитика (в разработке)')),
    const SettingsView(),
  ];

  Widget _buildNavItem(
    int index,
    IconData icon,
    IconData activeIcon,
    String label,
    bool isExpanded,
  ) {
    final isSelected = _selectedIndex == index;
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Material(
        color: isSelected
            ? context.primary.withValues(alpha: 0.15)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          hoverColor: context.hover,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              width: isExpanded ? 216 : 48,
              child: Row(
                mainAxisAlignment: isExpanded
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  if (isExpanded) const SizedBox(width: 16),
                  Icon(
                    isSelected ? activeIcon : icon,
                    color: isSelected ? context.primary : context.textMuted,
                    size: 20,
                  ),
                  if (isExpanded) const SizedBox(width: 16),
                  if (isExpanded)
                    Text(
                      label,
                      style: TextStyle(
                        color: isSelected ? context.primary : context.textMuted,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: _isSidebarExpanded,
            builder: (context, isExpanded, _) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: isExpanded ? 240 : 72,
                color: context.brightness == Brightness.dark
                    ? (globalDarkStyle.value == 'Midnight'
                          ? const Color(0xFF080C14)
                          : const Color(0xFF0A0A0A))
                    : Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        child: SizedBox(
                          width: isExpanded ? 240 : 72,
                          child: Row(
                            mainAxisAlignment: isExpanded
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.center,
                            children: [
                              if (isExpanded) const SizedBox(width: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: context.primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.blur_on_rounded,
                                    color: context.primary,
                                  ),
                                  onPressed: () {
                                    _isSidebarExpanded.value =
                                        !_isSidebarExpanded.value;
                                  },
                                ),
                              ),
                              if (isExpanded) const SizedBox(width: 12),
                              if (isExpanded)
                                const Text(
                                  'Sklad CRM',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      // ИСПРАВЛЕНО: Центрирование элементов меню
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: [
                            _buildNavItem(
                              0,
                              Icons.grid_view_outlined,
                              Icons.grid_view_rounded,
                              'Дашборд',
                              isExpanded,
                            ),
                            _buildNavItem(
                              1,
                              Icons.groups_outlined,
                              Icons.groups,
                              'Команда',
                              isExpanded,
                            ),
                            _buildNavItem(
                              2,
                              Icons.layers_outlined,
                              Icons.layers,
                              'Зоны',
                              isExpanded,
                            ),
                            _buildNavItem(
                              3,
                              Icons.inventory_2_outlined,
                              Icons.inventory_2,
                              'Товары',
                              isExpanded,
                            ),
                            _buildNavItem(
                              4,
                              Icons.category_outlined,
                              Icons.category,
                              'Номенклатура',
                              isExpanded,
                            ),
                            _buildNavItem(
                              5,
                              Icons.insights_outlined,
                              Icons.insights,
                              'Аналитика',
                              isExpanded,
                            ),
                            _buildNavItem(
                              6,
                              Icons.settings_outlined,
                              Icons.settings,
                              'Настройки',
                              isExpanded,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ИСПРАВЛЕНО: Блок пользователя (дизайн светлой темы + меню действий)
                    Container(
                      height: 64,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      child: Material(
                        color: context.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: context.border),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: PopupMenuButton<String>(
                          tooltip: 'Аккаунт',
                          offset: const Offset(0, -100),
                          color: context.card,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          onSelected: (value) {
                            if (value == 'settings') {
                              setState(() {
                                _selectedIndex = 6;
                              });
                            }
                            if (value == 'logout') {
                              showDialog<void>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Выход из аккаунта'),
                                  content: const Text(
                                    'В демо-версии выход не реализован.',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 'settings',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.manage_accounts,
                                    color: context.textMain,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Настройки аккаунта',
                                    style: TextStyle(color: context.textMain),
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuDivider(),
                            const PopupMenuItem(
                              value: 'logout',
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Выйти',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            child: SizedBox(
                              width: isExpanded ? 216 : 48,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: isExpanded
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundColor: context.primary
                                              .withValues(alpha: 0.2),
                                          child: Icon(
                                            Icons.admin_panel_settings,
                                            size: 18,
                                            color: context.primary,
                                          ),
                                        ),
                                        ValueListenableBuilder<String>(
                                          valueListenable: globalUserStatus,
                                          builder: (context, status, _) {
                                            return Positioned(
                                              right: 0,
                                              bottom: 0,
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                decoration: BoxDecoration(
                                                  color: getStatusColor(
                                                    context,
                                                    status,
                                                  ),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: context.surface,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    if (isExpanded) const SizedBox(width: 12),
                                    if (isExpanded)
                                      Expanded(
                                        child: ValueListenableBuilder<String>(
                                          valueListenable: globalUserStatus,
                                          builder: (context, status, _) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  globalUserName.value,
                                                  style: TextStyle(
                                                    color: context.textMain,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  status,
                                                  style: TextStyle(
                                                    color: getStatusColor(
                                                      context,
                                                      status,
                                                    ),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // ИСПРАВЛЕНО: Защита только контентной части, чтобы сайдбар не лагал
          Expanded(
            child: ResponsiveScrollWrapper(child: _screens[_selectedIndex]),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// НАСТРОЙКИ СИСТЕМЫ
// ============================================================================
