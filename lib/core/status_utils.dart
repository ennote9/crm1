import 'package:flutter/material.dart';

/// Цвет по статусу сотрудника/сущности. Единое место для меню, гридов и карточек.
Color getStatusColor(BuildContext context, String status) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  if (status == 'Активен') {
    return isDark ? Colors.greenAccent : Colors.green.shade700;
  }
  if (status == 'В отпуске') {
    return isDark ? Colors.orangeAccent : Colors.orange.shade800;
  }
  if (status == 'Больничный') {
    return isDark ? Colors.redAccent : Colors.red.shade700;
  }
  if (status == 'Отсутствует') {
    return isDark ? Colors.purpleAccent : Colors.purple.shade700;
  }
  if (status == 'В архиве') {
    return Colors.grey;
  }
  return isDark ? Colors.white54 : Colors.black54;
}
