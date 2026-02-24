import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ограничиваем минимальный размер окна, чтобы избежать артефактов и горизонтальных оверфлоу
  await windowManager.ensureInitialized();
  const minSize = Size(1200, 700);
  await windowManager.setMinimumSize(minSize);

  runApp(const SkladApp());
}
