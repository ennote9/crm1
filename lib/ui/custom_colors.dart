import 'package:flutter/material.dart';

import '../app/settings_store.dart';

extension CustomColors on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  Color get bg {
    if (brightness == Brightness.light) {
      if (globalLightStyle.value == 'Мягкая') {
        return const Color(0xFFF3F4F6);
      }
      if (globalLightStyle.value == 'Чистый белый') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'Warm Light') {
        return const Color(0xFFFDFBF7);
      }
      if (globalLightStyle.value == 'Corporate') {
        return const Color(0xFFECEFF1);
      }
      if (globalLightStyle.value == 'Документ') {
        return const Color(0xFFF5F5F7);
      }
      if (globalLightStyle.value == 'Pastel') {
        return const Color(0xFFFDF7FB);
      }
      if (globalLightStyle.value == 'High Contrast Light') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'Warm Gray') {
        return const Color(0xFFF4F1EC);
      }
      if (globalLightStyle.value == 'Cool Gray') {
        return const Color(0xFFF3F6F9);
      }
      return const Color(0xFFFAFAFA);
    } else {
      if (globalDarkStyle.value == 'Midnight') {
        return const Color(0xFF0B0F19);
      }
      if (globalDarkStyle.value == 'AMOLED') {
        return Colors.black;
      }
      if (globalDarkStyle.value == 'Ocean Dark') {
        return const Color(0xFF0F172A);
      }
      if (globalDarkStyle.value == 'Dracula') {
        return const Color(0xFF282A36);
      }
      if (globalDarkStyle.value == 'Graphite Dark') {
        return const Color(0xFF181A1F);
      }
      if (globalDarkStyle.value == 'Nord Dark') {
        return const Color(0xFF2E3440);
      }
      if (globalDarkStyle.value == 'Deep Space') {
        return const Color(0xFF050816);
      }
      if (globalDarkStyle.value == 'Forest Night') {
        return const Color(0xFF0B1F16);
      }
      if (globalDarkStyle.value == 'Solarized Dark') {
        return const Color(0xFF002B36);
      }
      return const Color(0xFF141414);
    }
  }

  Color get card {
    if (brightness == Brightness.light) {
      if (globalLightStyle.value == 'Мягкая') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'Чистый белый') {
        return const Color(0xFFF9FAFB);
      }
      if (globalLightStyle.value == 'Warm Light') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'Corporate') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'Документ') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'Pastel') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'High Contrast Light') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'Warm Gray') {
        return Colors.white;
      }
      if (globalLightStyle.value == 'Cool Gray') {
        return Colors.white;
      }
      return Colors.white;
    } else {
      if (globalDarkStyle.value == 'Midnight') {
        return const Color(0xFF131A2A);
      }
      if (globalDarkStyle.value == 'AMOLED') {
        return const Color(0xFF0A0A0A);
      }
      if (globalDarkStyle.value == 'Ocean Dark') {
        return const Color(0xFF1E293B);
      }
      if (globalDarkStyle.value == 'Dracula') {
        return const Color(0xFF44475A);
      }
      if (globalDarkStyle.value == 'Graphite Dark') {
        return const Color(0xFF21252B);
      }
      if (globalDarkStyle.value == 'Nord Dark') {
        return const Color(0xFF3B4252);
      }
      if (globalDarkStyle.value == 'Deep Space') {
        return const Color(0xFF0B1020);
      }
      if (globalDarkStyle.value == 'Forest Night') {
        return const Color(0xFF123526);
      }
      if (globalDarkStyle.value == 'Solarized Dark') {
        return const Color(0xFF073642);
      }
      return const Color(0xFF1A1A1A);
    }
  }

  Color get surface {
    if (brightness == Brightness.light) {
      if (globalLightStyle.value == 'Мягкая') {
        return const Color(0xFFE5E7EB);
      }
      if (globalLightStyle.value == 'Чистый белый') {
        return const Color(0xFFF3F4F6);
      }
      if (globalLightStyle.value == 'Warm Light') {
        return const Color(0xFFF5F0E6);
      }
      if (globalLightStyle.value == 'Corporate') {
        return const Color(0xFFCFD8DC);
      }
      if (globalLightStyle.value == 'Документ') {
        return const Color(0xFFE1E4EA);
      }
      if (globalLightStyle.value == 'Pastel') {
        return const Color(0xFFF4E9F7);
      }
      if (globalLightStyle.value == 'High Contrast Light') {
        return const Color(0xFFE5E5E5);
      }
      if (globalLightStyle.value == 'Warm Gray') {
        return const Color(0xFFE5DED2);
      }
      if (globalLightStyle.value == 'Cool Gray') {
        return const Color(0xFFE0E6EF);
      }
      return const Color(0xFFF3F4F6);
    } else {
      if (globalDarkStyle.value == 'Midnight') {
        return const Color(0xFF1C2438);
      }
      if (globalDarkStyle.value == 'AMOLED') {
        return const Color(0xFF111111);
      }
      if (globalDarkStyle.value == 'Ocean Dark') {
        return const Color(0xFF334155);
      }
      if (globalDarkStyle.value == 'Dracula') {
        return const Color(0xFF6272A4);
      }
      if (globalDarkStyle.value == 'Graphite Dark') {
        return const Color(0xFF2C313A);
      }
      if (globalDarkStyle.value == 'Nord Dark') {
        return const Color(0xFF434C5E);
      }
      if (globalDarkStyle.value == 'Deep Space') {
        return const Color(0xFF141A2A);
      }
      if (globalDarkStyle.value == 'Forest Night') {
        return const Color(0xFF184133);
      }
      if (globalDarkStyle.value == 'Solarized Dark') {
        return const Color(0xFF09424F);
      }
      return const Color(0xFF222222);
    }
  }

  Color get textMain =>
      brightness == Brightness.dark ? Colors.white : Colors.black87;
  Color get textMuted =>
      brightness == Brightness.dark ? Colors.white54 : Colors.black54;
  Color get border =>
      brightness == Brightness.dark ? Colors.white10 : Colors.black12;
  Color get hover => brightness == Brightness.dark
      ? const Color(0xFF2A2A2A)
      : Colors.grey.shade200;
  Color get primary => globalPrimaryColor.value;
  Color get orange => brightness == Brightness.dark
      ? Colors.orangeAccent
      : Colors.orange.shade800;
}
