import 'package:flutter/material.dart';

import '../../layout/responsive_wrapper.dart';
import '../../ui/custom_colors.dart';

/// Диалог выбора периода отсутствия (отпуск, больничный и т.п.).
class AbsenceDialog extends StatefulWidget {
  const AbsenceDialog({super.key});
  @override
  State<AbsenceDialog> createState() => _AbsenceDialogState();
}

class _AbsenceDialogState extends State<AbsenceDialog> {
  DateTime? _start;
  DateTime? _end;

  Future<void> _pickDate(bool isStart) async {
    try {
      final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 30)),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: context.primary,
              onPrimary: Colors.white,
              surface: context.card,
              onSurface: context.textMain,
            ),
          ),
          child: child!,
        ),
      );
      if (picked != null && mounted) {
        setState(() {
          if (isStart) {
            _start = picked;
            if (_end != null && _end!.isBefore(_start!)) {
              _end = null;
            }
          } else {
            _end = picked;
          }
        });
      }
    } catch (e, _) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось выбрать дату: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.bg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: DialogScrollWrapper(
          minWidth: 350,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Выбор периода',
                  style: TextStyle(
                    color: context.textMain,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildDateBox('Начало', _start, () {
                        _pickDate(true);
                      }),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white38,
                      ),
                    ),
                    Expanded(
                      child: _buildDateBox('Конец', _end, () {
                        _pickDate(false);
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Отмена',
                        style: TextStyle(color: context.textMuted),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: (_start != null && _end != null)
                          ? () {
                              String format(DateTime d) =>
                                  "${d.day.toString().padLeft(2, '0')}.${d.month.toString().padLeft(2, '0')}.${d.year}";
                              Navigator.pop(
                                context,
                                "${format(_start!)} - ${format(_end!)}",
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Сохранить'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateBox(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: context.textMuted, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Text(
              date != null
                  ? "${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}"
                  : "Выберите",
              style: TextStyle(
                color: date != null ? context.textMain : context.textMuted,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
