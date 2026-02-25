import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:crm1/core/grid_models.dart';
import 'package:crm1/widgets/erp_data_grid.dart';

void main() {
  testWidgets('ErpDataGrid shows header and rows', (tester) async {
    final columns = [
      ColumnConfig(key: 'name', title: 'Name', width: 100),
    ];
    final items = [
      {'name': 'First'},
      {'name': 'Second'},
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 400,
            height: 300,
            child: ErpDataGrid(
              items: items,
              columns: columns,
              cellBuilder: (context, item, col, index) =>
                  Text(item[col.key] as String),
            ),
          ),
        ),
      ),
    );

    expect(find.text('NAME'), findsOneWidget);
    expect(find.text('First'), findsOneWidget);
    expect(find.text('Second'), findsOneWidget);
  });

  test('tableWidthForColumns sums column widths', () {
    final columns = [
      ColumnConfig(key: 'a', title: 'A', width: 100),
      ColumnConfig(key: 'b', title: 'B', width: 150),
    ];
    final w = ErpDataGrid.tableWidthForColumns(columns);
    expect(w, 100 + 150 + 80 + 48); // menuColumn 80 + rowPaddingH*2 24*2
  });
}
