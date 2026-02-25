import 'package:flutter/material.dart';

import '../ui/custom_colors.dart';

/// Блок только с заголовком экрана (иконка + название). Строка фильтров выносится отдельно — [ErpListFilterRow].
class ErpListToolbar extends StatelessWidget {
  final String title;
  final IconData titleIcon;

  const ErpListToolbar({
    super.key,
    required this.title,
    required this.titleIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(titleIcon, color: context.primary),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: context.textMain,
          ),
        ),
      ],
    );
  }
}
