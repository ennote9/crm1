import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crm1/widgets/erp_list_toolbar.dart';

void main() {
  testWidgets('ErpListToolbar shows title and icon', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErpListToolbar(
            title: 'Складские зоны',
            titleIcon: Icons.layers_outlined,
          ),
        ),
      ),
    );

    expect(find.text('Складские зоны'), findsOneWidget);
    expect(find.byIcon(Icons.layers_outlined), findsOneWidget);
  });
}
