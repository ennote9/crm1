import 'package:flutter/material.dart';

import '../../app/settings_store.dart';
import '../../ui/custom_colors.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      color: context.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Настройки системы',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: context.textMain,
            ),
          ),
          const SizedBox(height: 32),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => const ThemeSettingsDialog(),
              );
            },
            borderRadius: BorderRadius.circular(16),
            hoverColor: context.hover,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: context.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.border),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.palette_outlined, color: context.primary),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Внешний вид',
                          style: TextStyle(
                            color: context.textMain,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Темы, акцентные цвета и масштабирование',
                          style: TextStyle(
                            color: context.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: context.textMuted),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThemeSettingsDialog extends StatelessWidget {
  const ThemeSettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Color> allColors = [
      Colors.blue,
      Colors.blue.shade400,
      Colors.indigo,
      Colors.indigo.shade400,
      Colors.teal,
      Colors.teal.shade400,
      Colors.green,
      Colors.green.shade400,
      Colors.orange,
      Colors.orange.shade400,
      Colors.deepOrange,
      Colors.brown.shade400,
      Colors.red,
      Colors.red.shade400,
      Colors.pink,
      Colors.pink.shade400,
      Colors.purple,
      Colors.purple.shade400,
      Colors.deepPurple,
      Colors.deepPurple.shade400,
      Colors.blueGrey,
      Colors.blueGrey.shade400,
      const Color(0xFF141414),
      Colors.black87,
    ];

    return Dialog(
      backgroundColor: context.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 500,
          maxHeight: 750,
        ), // Жесткая высота защищает от Overflow
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Настройки интерфейса',
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
                Text(
                  'Режим отображения',
                  style: TextStyle(
                    color: context.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: globalThemeMode,
                  builder: (context, mode, _) {
                    return Row(
                      children: [
                        _buildThemeBtn(
                          context,
                          'Светлая',
                          Icons.light_mode,
                          ThemeMode.light,
                          mode,
                          () {
                            globalThemeMode.value = ThemeMode.light;
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildThemeBtn(
                          context,
                          'Темная',
                          Icons.dark_mode,
                          ThemeMode.dark,
                          mode,
                          () {
                            globalThemeMode.value = ThemeMode.dark;
                          },
                        ),
                        const SizedBox(width: 12),
                        _buildThemeBtn(
                          context,
                          'Система',
                          Icons.brightness_auto,
                          ThemeMode.system,
                          mode,
                          () {
                            globalThemeMode.value = ThemeMode.system;
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Стиль темы',
                  style: TextStyle(
                    color: context.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<ThemeMode>(
                  valueListenable: globalThemeMode,
                  builder: (context, mode, _) {
                    final isDark =
                        mode == ThemeMode.dark ||
                        (mode == ThemeMode.system &&
                            MediaQuery.of(context).platformBrightness ==
                                Brightness.dark);
                    return ValueListenableBuilder<String>(
                      valueListenable: isDark
                          ? globalDarkStyle
                          : globalLightStyle,
                      builder: (context, variant, _) {
                        final styles = isDark
                            ? [
                                'Стандартная',
                                'Midnight',
                                'AMOLED',
                                'Ocean Dark',
                                'Dracula',
                              ]
                            : [
                                'Стандартная',
                                'Мягкая',
                                'Чистый белый',
                                'Warm Light',
                                'Corporate',
                              ];
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: styles.map((style) {
                            final isSelected = style == variant;
                            return InkWell(
                              onTap: () {
                                if (isDark) {
                                  globalDarkStyle.value = style;
                                } else {
                                  globalLightStyle.value = style;
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? context.primary.withValues(alpha: 0.15)
                                      : context.card,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? context.primary
                                        : context.border,
                                  ),
                                ),
                                child: Text(
                                  style,
                                  style: TextStyle(
                                    color: isSelected
                                        ? context.primary
                                        : context.textMuted,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  'Акцентный цвет',
                  style: TextStyle(
                    color: context.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<Color>(
                  valueListenable: globalPrimaryColor,
                  builder: (context, currentColor, _) {
                    return Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: allColors.map((color) {
                        final isSelected = currentColor == color;
                        return InkWell(
                          onTap: () {
                            globalPrimaryColor.value = color;
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: isSelected
                                  ? Border.all(
                                      color: context.textMain,
                                      width: 3,
                                    )
                                  : Border.all(color: context.border),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: color.computeLuminance() > 0.5
                                        ? Colors.black
                                        : Colors.white,
                                    size: 16,
                                  )
                                : null,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  'Масштаб интерфейса',
                  style: TextStyle(
                    color: context.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<double>(
                  valueListenable: globalTextScale,
                  builder: (context, scale, _) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Размер текста',
                              style: TextStyle(color: context.textMuted),
                            ),
                            Text(
                              '${(scale * 100).toInt()}%',
                              style: TextStyle(
                                color: context.textMain,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: scale,
                          min: 0.8,
                          max: 1.2,
                          divisions: 4,
                          activeColor: context.primary,
                          inactiveColor: context.border,
                          onChanged: (v) {
                            globalTextScale.value = v;
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Готово'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeBtn(
    BuildContext context,
    String label,
    IconData icon,
    ThemeMode mode,
    ThemeMode current,
    VoidCallback onTap,
  ) {
    final isSelected = mode == current;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? context.primary.withValues(alpha: 0.15)
                : context.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? context.primary : context.border,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? context.primary : context.textMuted,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? context.primary : context.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// ДИАЛОГ ВЫБОРА ДАТЫ ОТСУТСТВИЯ
// ============================================================================
