import 'package:flutter/material.dart';

import '../../ui/custom_colors.dart';
import 'shifts_constants.dart';

/// Диалог выдачи/редактирования имущества сотрудника. Контроллеры создаются и удаляются внутри виджета.
class ShiftsInventoryDialog extends StatefulWidget {
  final Map<String, dynamic>? item;
  final int? index;

  const ShiftsInventoryDialog({
    super.key,
    this.item,
    this.index,
  });

  static IconData _getInventoryIcon(String type) {
    switch (type) {
      case 'Ноутбук / ПК':
        return Icons.laptop_mac;
      case 'ТСД Сканер':
        return Icons.qr_code_scanner;
      case 'Рация':
        return Icons.speaker_phone;
      case 'Спецодежда':
        return Icons.checkroom;
      case 'Ключи':
        return Icons.key;
      default:
        return Icons.inventory_2;
    }
  }

  @override
  State<ShiftsInventoryDialog> createState() => _ShiftsInventoryDialogState();
}

class _ShiftsInventoryDialogState extends State<ShiftsInventoryDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _detailsCtrl;
  late final TextEditingController _purposeCtrl;
  String _condition = 'Новое';
  String _status = 'Выдано';
  String _invType = globalInventoryTypes[0];

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _nameCtrl = TextEditingController(text: item?['name'] ?? '');
    _detailsCtrl = TextEditingController(text: item?['details'] ?? '');
    _purposeCtrl = TextEditingController(text: item?['purpose'] ?? '');
    _condition = item?['condition'] ?? 'Новое';
    _status = item?['status'] ?? 'Выдано';
    _invType = item?['type'] ?? globalInventoryTypes[0];
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _detailsCtrl.dispose();
    _purposeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return AlertDialog(
      backgroundColor: context.bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        item == null ? 'Выдать имущество' : 'Редактировать имущество',
        style: TextStyle(
          color: context.textMain,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: context.card,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _invType,
                  icon: Icon(Icons.keyboard_arrow_down, color: context.textMuted),
                  dropdownColor: context.card,
                  borderRadius: BorderRadius.circular(12),
                  elevation: 6,
                  style: TextStyle(color: context.textMain),
                  isExpanded: true,
                  items: globalInventoryTypes
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Row(
                            children: [
                              Icon(
                                ShiftsInventoryDialog._getInventoryIcon(c),
                                size: 18,
                                color: context.textMuted,
                              ),
                              const SizedBox(width: 8),
                              Text(c),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _invType = v);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameCtrl,
              style: TextStyle(color: context.textMain),
              decoration: InputDecoration(
                filled: true,
                fillColor: context.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Модель (напр. Honeywell)',
                hintStyle: TextStyle(
                  color: context.textMuted.withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detailsCtrl,
              style: TextStyle(color: context.textMain),
              decoration: InputDecoration(
                filled: true,
                fillColor: context.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Серийный или Инв. номер',
                hintStyle: TextStyle(
                  color: context.textMuted.withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _purposeCtrl,
              style: TextStyle(color: context.textMain),
              decoration: InputDecoration(
                filled: true,
                fillColor: context.card,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Цель выдачи',
                hintStyle: TextStyle(
                  color: context.textMuted.withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _condition,
                        icon: Icon(Icons.keyboard_arrow_down, color: context.textMuted),
                        dropdownColor: context.card,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 6,
                        style: TextStyle(color: context.textMain),
                        isExpanded: true,
                        items: ['Новое', 'Хорошее', 'Б/У', 'Требует ремонта']
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _condition = v);
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _status,
                        icon: Icon(Icons.keyboard_arrow_down, color: context.textMuted),
                        dropdownColor: context.card,
                        borderRadius: BorderRadius.circular(12),
                        elevation: 6,
                        style: TextStyle(color: context.textMain),
                        isExpanded: true,
                        items: ['Выдано', 'Изъято', 'На ремонте']
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _status = v);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Отмена', style: TextStyle(color: context.textMuted)),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, {
              'name': _nameCtrl.text,
              'details': _detailsCtrl.text,
              'purpose': _purposeCtrl.text,
              'condition': _condition,
              'status': _status,
              'type': _invType,
              'issueDate': item?['issueDate'],
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: context.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Сохранить', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
