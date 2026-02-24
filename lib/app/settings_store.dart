import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> globalThemeMode = ValueNotifier(ThemeMode.dark);
final ValueNotifier<String> globalDarkStyle = ValueNotifier('Стандартная');
final ValueNotifier<String> globalLightStyle = ValueNotifier('Стандартная');
final ValueNotifier<Color> globalPrimaryColor = ValueNotifier(
  Colors.blueAccent,
);
final ValueNotifier<double> globalTextScale = ValueNotifier(1.0);
final ValueNotifier<String> globalFontFamily = ValueNotifier('-apple-system');

/// Глобальный статус текущего пользователя (Активен, В отпуске, Больничный и т.п.).
/// Сейчас используется в боковом меню; в будущем может синхронизироваться с HR/учетной записью.
final ValueNotifier<String> globalUserStatus = ValueNotifier('Активен');
