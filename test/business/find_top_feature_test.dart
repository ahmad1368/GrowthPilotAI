import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_top_feature.dart';

void main() {
  group('FindTopFeature', () {
    test('returns the key with the highest weight', () {
      final top = FindTopFeature.call({'rent': 0.15, 'payroll': 0.45, 'materials': 0.4});

      expect(top, 'payroll');
    });

    test('a single-entry map returns that entry', () {
      expect(FindTopFeature.call({'only': 1.0}), 'only');
    });
  });
}
