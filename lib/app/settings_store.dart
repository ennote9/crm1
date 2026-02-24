import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> globalThemeMode = ValueNotifier(ThemeMode.dark);
final ValueNotifier<String> globalDarkStyle = ValueNotifier('Стандартная');
final ValueNotifier<String> globalLightStyle = ValueNotifier('Стандартная');
final ValueNotifier<Color> globalPrimaryColor = ValueNotifier(
  Colors.blueAccent,
);
final ValueNotifier<double> globalTextScale = ValueNotifier(1.0);
final ValueNotifier<String> globalFontFamily = ValueNotifier('-apple-system');
