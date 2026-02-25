import 'package:flutter/material.dart';

import '../layout/main_layout.dart';
import '../ui/theme_palette.dart';
import 'settings_store.dart';

class SkladApp extends StatelessWidget {
  const SkladApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeListenable,
      builder: (context, _) {
        final mode = globalThemeMode.value;
        final darkStyle = globalDarkStyle.value;
        final lightStyle = globalLightStyle.value;
        final color = globalPrimaryColor.value;
        final fontFam = globalFontFamily.value;
        final scale = globalTextScale.value;

        final darkPalette = ThemePalette.dark(darkStyle);
        final lightPalette = ThemePalette.light(lightStyle);

        return MaterialApp(
          title: 'Склад CRM',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          builder: (context, child) {
            final mq = MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(scale),
            );
            if (child == null) {
              return MediaQuery(
                data: mq,
                child: const SizedBox.shrink(),
              );
            }
            return MediaQuery(
              data: mq,
              child: Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) => SelectionArea(child: child),
                  ),
                ],
              ),
            );
          },
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: color,
            scaffoldBackgroundColor: lightPalette.bg,
            cardColor: lightPalette.card,
            canvasColor: lightPalette.surface,
            dialogTheme: DialogThemeData(
              backgroundColor: lightPalette.card,
            ),
            fontFamily: fontFam,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: color,
            scaffoldBackgroundColor: darkPalette.bg,
            cardColor: darkPalette.card,
            canvasColor: darkPalette.surface,
            dialogTheme: DialogThemeData(
              backgroundColor: darkPalette.card,
            ),
            fontFamily: fontFam,
          ),
          home: const MainLayout(),
        );
      },
    );
  }
}
