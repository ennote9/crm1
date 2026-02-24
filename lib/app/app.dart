import 'package:flutter/material.dart';

import '../layout/main_layout.dart';
import 'settings_store.dart';

class SkladApp extends StatelessWidget {
  const SkladApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: globalThemeMode,
      builder: (context, mode, _) {
        return ValueListenableBuilder<String>(
          valueListenable: globalDarkStyle,
          builder: (context, darkStyle, _) {
            return ValueListenableBuilder<String>(
              valueListenable: globalLightStyle,
              builder: (context, lightStyle, _) {
                return ValueListenableBuilder<Color>(
                  valueListenable: globalPrimaryColor,
                  builder: (context, color, _) {
                    return ValueListenableBuilder<String>(
                      valueListenable: globalFontFamily,
                      builder: (context, fontFam, _) {
                        return ValueListenableBuilder<double>(
                          valueListenable: globalTextScale,
                          builder: (context, scale, _) {
                            Color darkBg = const Color(0xFF141414);
                            Color darkCard = const Color(0xFF1A1A1A);
                            Color darkSurface = const Color(0xFF222222);
                            if (darkStyle == 'Midnight') {
                              darkBg = const Color(0xFF0B0F19);
                              darkCard = const Color(0xFF131A2A);
                              darkSurface = const Color(0xFF1C2438);
                            }
                            if (darkStyle == 'AMOLED') {
                              darkBg = Colors.black;
                              darkCard = const Color(0xFF0A0A0A);
                              darkSurface = const Color(0xFF111111);
                            }
                            if (darkStyle == 'Ocean Dark') {
                              darkBg = const Color(0xFF0F172A);
                              darkCard = const Color(0xFF1E293B);
                              darkSurface = const Color(0xFF334155);
                            }
                            if (darkStyle == 'Dracula') {
                              darkBg = const Color(0xFF282A36);
                              darkCard = const Color(0xFF44475A);
                              darkSurface = const Color(0xFF6272A4);
                            }
                            if (darkStyle == 'Graphite Dark') {
                              darkBg = const Color(0xFF181A1F);
                              darkCard = const Color(0xFF21252B);
                              darkSurface = const Color(0xFF2C313A);
                            }
                            if (darkStyle == 'Nord Dark') {
                              darkBg = const Color(0xFF2E3440);
                              darkCard = const Color(0xFF3B4252);
                              darkSurface = const Color(0xFF434C5E);
                            }
                            if (darkStyle == 'Deep Space') {
                              darkBg = const Color(0xFF050816);
                              darkCard = const Color(0xFF0B1020);
                              darkSurface = const Color(0xFF141A2A);
                            }
                            if (darkStyle == 'Forest Night') {
                              darkBg = const Color(0xFF0B1F16);
                              darkCard = const Color(0xFF123526);
                              darkSurface = const Color(0xFF184133);
                            }
                            if (darkStyle == 'Solarized Dark') {
                              darkBg = const Color(0xFF002B36);
                              darkCard = const Color(0xFF073642);
                              darkSurface = const Color(0xFF09424F);
                            }

                            Color lightBg = const Color(0xFFFAFAFA);
                            Color lightCard = Colors.white;
                            Color lightSurface = const Color(0xFFF3F4F6);
                            if (lightStyle == 'Мягкая') {
                              lightBg = const Color(0xFFF3F4F6);
                              lightCard = Colors.white;
                              lightSurface = const Color(0xFFE5E7EB);
                            }
                            if (lightStyle == 'Чистый белый') {
                              lightBg = Colors.white;
                              lightCard = const Color(0xFFF9FAFB);
                              lightSurface = const Color(0xFFF3F4F6);
                            }
                            if (lightStyle == 'Warm Light') {
                              lightBg = const Color(0xFFFDFBF7);
                              lightCard = Colors.white;
                              lightSurface = const Color(0xFFF5F0E6);
                            }
                            if (lightStyle == 'Corporate') {
                              lightBg = const Color(0xFFECEFF1);
                              lightCard = Colors.white;
                              lightSurface = const Color(0xFFCFD8DC);
                            }
                            if (lightStyle == 'Документ') {
                              lightBg = const Color(0xFFF5F5F7);
                              lightCard = Colors.white;
                              lightSurface = const Color(0xFFE1E4EA);
                            }
                            if (lightStyle == 'Pastel') {
                              lightBg = const Color(0xFFFDF7FB);
                              lightCard = Colors.white;
                              lightSurface = const Color(0xFFF4E9F7);
                            }
                            if (lightStyle == 'High Contrast Light') {
                              lightBg = Colors.white;
                              lightCard = Colors.white;
                              lightSurface = const Color(0xFFE5E5E5);
                            }
                            if (lightStyle == 'Warm Gray') {
                              lightBg = const Color(0xFFF4F1EC);
                              lightCard = Colors.white;
                              lightSurface = const Color(0xFFE5DED2);
                            }
                            if (lightStyle == 'Cool Gray') {
                              lightBg = const Color(0xFFF3F6F9);
                              lightCard = Colors.white;
                              lightSurface = const Color(0xFFE0E6EF);
                            }

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
                                // FIX: SelectionArea требует Overlay-ancestor. В MaterialApp.builder мы
                                // находимся выше Navigator/Overlay, поэтому добавляем локальный Overlay.
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
                                scaffoldBackgroundColor: lightBg,
                                cardColor: lightCard,
                                canvasColor: lightSurface,
                                dialogTheme: DialogThemeData(
                                  backgroundColor: lightCard,
                                ),
                                fontFamily: fontFam,
                              ),
                              darkTheme: ThemeData(
                                brightness: Brightness.dark,
                                primaryColor: color,
                                scaffoldBackgroundColor: darkBg,
                                cardColor: darkCard,
                                canvasColor: darkSurface,
                                dialogTheme: DialogThemeData(
                                  backgroundColor: darkCard,
                                ),
                                fontFamily: fontFam,
                              ),
                              home: const MainLayout(),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
