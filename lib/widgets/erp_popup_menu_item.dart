import 'package:flutter/material.dart';

import '../ui/custom_colors.dart';

/// Возвращает пункт меню с иконкой и текстом в едином стиле (для PopupMenuButton в гридах и тулбарах).
PopupMenuEntry<String> erpPopupMenuItem(
  BuildContext context, {
  required String value,
  required IconData icon,
  required String label,
  bool isDestructive = false,
}) {
  final color = isDestructive ? Colors.redAccent : context.textMain;
  return PopupMenuItem<String>(
    value: value,
    child: Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: color)),
      ],
    ),
  );
}
