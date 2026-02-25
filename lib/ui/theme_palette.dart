import 'package:flutter/material.dart';

/// Три основных цвета фона для стиля: фон экрана, карточки, поверхности (списки, поля).
class ThemePaletteColors {
  const ThemePaletteColors({
    required this.bg,
    required this.card,
    required this.surface,
  });
  final Color bg;
  final Color card;
  final Color surface;
}

/// Единый источник палитр для светлой и тёмной темы. Используется в app.dart и custom_colors.
class ThemePalette {
  ThemePalette._();

  static ThemePaletteColors dark(String styleName) {
    switch (styleName) {
      case 'Midnight':
        return const ThemePaletteColors(
          bg: Color(0xFF0B0F19),
          card: Color(0xFF131A2A),
          surface: Color(0xFF1C2438),
        );
      case 'AMOLED':
        return const ThemePaletteColors(
          bg: Colors.black,
          card: Color(0xFF0A0A0A),
          surface: Color(0xFF111111),
        );
      case 'Ocean Dark':
        return const ThemePaletteColors(
          bg: Color(0xFF0F172A),
          card: Color(0xFF1E293B),
          surface: Color(0xFF334155),
        );
      case 'Dracula':
        return const ThemePaletteColors(
          bg: Color(0xFF282A36),
          card: Color(0xFF44475A),
          surface: Color(0xFF6272A4),
        );
      case 'Graphite Dark':
        return const ThemePaletteColors(
          bg: Color(0xFF181A1F),
          card: Color(0xFF21252B),
          surface: Color(0xFF2C313A),
        );
      case 'Nord Dark':
        return const ThemePaletteColors(
          bg: Color(0xFF2E3440),
          card: Color(0xFF3B4252),
          surface: Color(0xFF434C5E),
        );
      case 'Deep Space':
        return const ThemePaletteColors(
          bg: Color(0xFF050816),
          card: Color(0xFF0B1020),
          surface: Color(0xFF141A2A),
        );
      case 'Forest Night':
        return const ThemePaletteColors(
          bg: Color(0xFF0B1F16),
          card: Color(0xFF123526),
          surface: Color(0xFF184133),
        );
      case 'Solarized Dark':
        return const ThemePaletteColors(
          bg: Color(0xFF002B36),
          card: Color(0xFF073642),
          surface: Color(0xFF09424F),
        );
      default:
        return const ThemePaletteColors(
          bg: Color(0xFF141414),
          card: Color(0xFF1A1A1A),
          surface: Color(0xFF222222),
        );
    }
  }

  static ThemePaletteColors light(String styleName) {
    switch (styleName) {
      case 'Мягкая':
        return const ThemePaletteColors(
          bg: Color(0xFFF3F4F6),
          card: Colors.white,
          surface: Color(0xFFE5E7EB),
        );
      case 'Чистый белый':
        return const ThemePaletteColors(
          bg: Colors.white,
          card: Color(0xFFF9FAFB),
          surface: Color(0xFFF3F4F6),
        );
      case 'Warm Light':
        return const ThemePaletteColors(
          bg: Color(0xFFFDFBF7),
          card: Colors.white,
          surface: Color(0xFFF5F0E6),
        );
      case 'Corporate':
        return const ThemePaletteColors(
          bg: Color(0xFFECEFF1),
          card: Colors.white,
          surface: Color(0xFFCFD8DC),
        );
      case 'Документ':
        return const ThemePaletteColors(
          bg: Color(0xFFF5F5F7),
          card: Colors.white,
          surface: Color(0xFFE1E4EA),
        );
      case 'Pastel':
        return const ThemePaletteColors(
          bg: Color(0xFFFDF7FB),
          card: Colors.white,
          surface: Color(0xFFF4E9F7),
        );
      case 'High Contrast Light':
        return const ThemePaletteColors(
          bg: Colors.white,
          card: Colors.white,
          surface: Color(0xFFE5E5E5),
        );
      case 'Warm Gray':
        return const ThemePaletteColors(
          bg: Color(0xFFF4F1EC),
          card: Colors.white,
          surface: Color(0xFFE5DED2),
        );
      case 'Cool Gray':
        return const ThemePaletteColors(
          bg: Color(0xFFF3F6F9),
          card: Colors.white,
          surface: Color(0xFFE0E6EF),
        );
      default:
        return const ThemePaletteColors(
          bg: Color(0xFFFAFAFA),
          card: Colors.white,
          surface: Color(0xFFF3F4F6),
        );
    }
  }
}
