import 'package:flutter/material.dart';

import '../app/settings_store.dart';
import '../ui/custom_colors.dart';
import '../features/dashboard/dashboard_view.dart';
import '../features/settings/settings_view.dart';
import '../features/shifts/shifts_view.dart';
import '../features/zones/zones_view.dart';
import 'responsive_wrapper.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 1;
  bool _isSidebarExpanded = false;

  final List<Widget> _screens = [
    const DashboardView(),
    const ShiftsView(),
    const ZonesView(),
    const Center(child: Text('Аналитика (в разработке)')),
    const SettingsView(),
  ];

  Widget _buildNavItem(
    int index,
    IconData icon,
    IconData activeIcon,
    String label,
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
              width: _isSidebarExpanded ? 216 : 48,
              child: Row(
                mainAxisAlignment: _isSidebarExpanded
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  if (_isSidebarExpanded) const SizedBox(width: 16),
                  Icon(
                    isSelected ? activeIcon : icon,
                    color: isSelected ? context.primary : context.textMuted,
                    size: 20,
                  ),
                  if (_isSidebarExpanded) const SizedBox(width: 16),
                  if (_isSidebarExpanded)
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
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: _isSidebarExpanded ? 240 : 72,
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
                      width: _isSidebarExpanded ? 240 : 72,
                      child: Row(
                        mainAxisAlignment: _isSidebarExpanded
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.center,
                        children: [
                          if (_isSidebarExpanded) const SizedBox(width: 16),
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
                                setState(() {
                                  _isSidebarExpanded = !_isSidebarExpanded;
                                });
                              },
                            ),
                          ),
                          if (_isSidebarExpanded) const SizedBox(width: 12),
                          if (_isSidebarExpanded)
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
                        ),
                        _buildNavItem(
                          1,
                          Icons.groups_outlined,
                          Icons.groups,
                          'Команда',
                        ),
                        _buildNavItem(
                          2,
                          Icons.layers_outlined,
                          Icons.layers,
                          'Зоны',
                        ),
                        _buildNavItem(
                          3,
                          Icons.insights_outlined,
                          Icons.insights,
                          'Аналитика',
                        ),
                        _buildNavItem(
                          4,
                          Icons.settings_outlined,
                          Icons.settings,
                          'Настройки',
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
                          width: _isSidebarExpanded ? 216 : 48,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: _isSidebarExpanded
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
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: context.surface,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (_isSidebarExpanded)
                                  const SizedBox(width: 12),
                                if (_isSidebarExpanded)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Iuldashev S.',
                                          style: TextStyle(
                                            color: context.textMain,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'В сети',
                                          style: TextStyle(
                                            color: Colors.greenAccent.shade700,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
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
