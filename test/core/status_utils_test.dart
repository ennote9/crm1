import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crm1/core/status_utils.dart';

void main() {
  testWidgets('getStatusColor returns color in dark theme', (tester) async {
    Color? captured;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Builder(
          builder: (context) {
            captured = getStatusColor(context, 'Активен');
            return const SizedBox();
          },
        ),
      ),
    );
    expect(captured, isNotNull);
    expect(captured, Colors.greenAccent);
  });

  testWidgets('getStatusColor В архиве returns grey', (tester) async {
    Color? captured;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Builder(
          builder: (context) {
            captured = getStatusColor(context, 'В архиве');
            return const SizedBox();
          },
        ),
      ),
    );
    expect(captured, Colors.grey);
  });
}
