import 'package:flutter/material.dart';

import '../../ui/custom_colors.dart';

class ZonesView extends StatelessWidget {
  const ZonesView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> zones = [
      {
        'name': 'Зона А (Сборка)',
        'capacity': 0.85,
        'status': 'Высокая нагрузка',
        'color': Colors.orangeAccent,
        'workers': 5,
      },
      {
        'name': 'Зона Б (Паллеты)',
        'capacity': 0.40,
        'status': 'В норме',
        'color': Colors.greenAccent,
        'workers': 2,
      },
      {
        'name': 'Пандус 1 (Приемка)',
        'capacity': 0.95,
        'status': 'Перегруз',
        'color': Colors.redAccent,
        'workers': 4,
      },
      {
        'name': 'Пандус 2 (Отгрузка)',
        'capacity': 0.10,
        'status': 'Свободно',
        'color': Colors.blueAccent,
        'workers': 1,
      },
      {
        'name': 'Холодильник',
        'capacity': 0.60,
        'status': 'В норме',
        'color': Colors.greenAccent,
        'workers': 2,
      },
    ];
    return Container(
      padding: const EdgeInsets.all(32.0),
      color: context.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Складские зоны',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: context.textMain,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.filter_list, color: context.textMain),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                mainAxisExtent: 200,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
              itemCount: zones.length,
              itemBuilder: (context, index) =>
                  _buildZoneCard(context, zones[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoneCard(BuildContext context, Map<String, dynamic> zone) =>
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    zone['name'] as String,
                    style: TextStyle(
                      color: context.textMain,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(Icons.inventory_2_outlined, color: context.textMuted),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Заполненность',
                  style: TextStyle(color: context.textMuted, fontSize: 14),
                ),
                Text(
                  '${(zone['capacity'] * 100).toInt()}%',
                  style: TextStyle(
                    color: context.textMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: zone['capacity'],
              backgroundColor: context.border,
              color: zone['color'],
              minHeight: 6,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (zone['color'] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    zone['status'],
                    style: TextStyle(
                      color: zone['color'],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.people, color: context.textMuted, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${zone['workers']}',
                      style: TextStyle(color: context.textMuted, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}
