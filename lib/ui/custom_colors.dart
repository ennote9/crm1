import 'package:flutter/material.dart';

import '../app/settings_store.dart';
import 'theme_palette.dart';

extension CustomColors on BuildContext {
  Brightness get brightness => Theme.of(this).brightness;

  Color get bg {
    if (brightness == Brightness.light) {
      return ThemePalette.light(globalLightStyle.value).bg;
    }
    return ThemePalette.dark(globalDarkStyle.value).bg;
  }

  Color get card {
    if (brightness == Brightness.light) {
      return ThemePalette.light(globalLightStyle.value).card;
    }
    return ThemePalette.dark(globalDarkStyle.value).card;
  }

  Color get surface {
    if (brightness == Brightness.light) {
      return ThemePalette.light(globalLightStyle.value).surface;
    }
    return ThemePalette.dark(globalDarkStyle.value).surface;
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
