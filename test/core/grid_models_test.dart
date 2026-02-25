import 'package:flutter_test/flutter_test.dart';

import 'package:crm1/core/grid_models.dart';

void main() {
  group('ColumnConfig', () {
    test('clone preserves fields', () {
      final c = ColumnConfig(key: 'a', title: 'A', isVisible: false, width: 100);
      final c2 = c.clone();
      expect(c2.key, 'a');
      expect(c2.title, 'A');
      expect(c2.isVisible, false);
      expect(c2.width, 100);
    });
  });

  group('GridState', () {
    late GridState state;

    setUp(() {
      state = GridState(
        defaultColumns: [
          ColumnConfig(key: 'name', title: 'Name', width: 150),
          ColumnConfig(key: 'id', title: 'ID', isVisible: false, width: 80),
        ],
      );
    });

    tearDown(() {
      state.dispose();
    });

    test('initial currentViewName is Стандартный вид', () {
      expect(state.currentViewName.value, 'Стандартный вид');
    });

    test('visibleColumns excludes isVisible false', () {
      expect(state.visibleColumns.length, 1);
      expect(state.visibleColumns.first.key, 'name');
    });

    test('presets contains one standard preset', () {
      expect(state.presets.value.length, 1);
      expect(state.presets.value.first.name, 'Стандартный вид');
      expect(state.presets.value.first.isStandard, true);
    });
  });
}
