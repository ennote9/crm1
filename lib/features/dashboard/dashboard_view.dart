import 'package:flutter/material.dart';

import '../../ui/custom_colors.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
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
                'Обзор смены',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: context.textMain,
                ),
              ),
              CircleAvatar(
                backgroundColor: context.primary,
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                context,
                                'Сотрудников',
                                '12',
                                '+2 с замены',
                                Colors.greenAccent,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(child: _buildCapacityCard(context)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildActivityCard(context),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(flex: 1, child: _buildTasksCard(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    String subtitle,
    Color badgeColor,
  ) => Container(
    height: 160,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: context.textMuted, fontSize: 16)),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              value,
              style: TextStyle(
                color: context.textMain,
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                subtitle,
                style: TextStyle(
                  color: badgeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  Widget _buildCapacityCard(BuildContext context) => Container(
    height: 160,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Загрузка склада',
          style: TextStyle(color: context.textMuted, fontSize: 16),
        ),
        const Spacer(),
        Text(
          '75%',
          style: TextStyle(
            color: context.textMain,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: 0.75,
          backgroundColor: context.border,
          color: context.primary,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    ),
  );
  Widget _buildActivityCard(BuildContext context) => Container(
    height: 300,
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Анализ "узких горлышек"',
          style: TextStyle(color: context.textMuted, fontSize: 16),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Center(
            child: Text(
              'Здесь позже нарисуем красивые графики\nскорости обработки зон',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: context.textMuted,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ],
    ),
  );
  Widget _buildTasksCard(BuildContext context) => Container(
    height: 484,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Задачи на смену',
              style: TextStyle(color: context.textMuted, fontSize: 16),
            ),
            Icon(Icons.add_circle, color: context.textMuted),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            children: const [
              _TaskItem(title: 'Приемка фуры (Зона А)', isUrgent: true),
              _TaskItem(
                title: 'Инструктаж SOP: Безопасный нож',
                isUrgent: false,
              ),
              _TaskItem(title: 'Сборка заказов (Зона Б)', isUrgent: false),
              _TaskItem(
                title: 'Проверка графиков замен на завтра',
                isUrgent: false,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _TaskItem extends StatelessWidget {
  final String title;
  final bool isUrgent;
  const _TaskItem({required this.title, required this.isUrgent});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: context.card,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Icon(
          isUrgent ? Icons.circle : Icons.circle_outlined,
          color: isUrgent ? Colors.redAccent : context.textMuted,
          size: 16,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: TextStyle(color: context.textMain, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}
