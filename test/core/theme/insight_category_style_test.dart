import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/theme/insight_category_style.dart';

void main() {
  group('InsightCategoryStyle', () {
    test('every ordered category has a distinct icon and color', () {
      final visuals =
          InsightCategoryStyle.orderedCategories.map(InsightCategoryStyle.forCategory).toList();

      expect(visuals.map((v) => v.icon).toSet().length, visuals.length);
      expect(visuals.map((v) => v.color).toSet().length, visuals.length);
    });

    test('falls back to a defined visual for an unknown category', () {
      final visual = InsightCategoryStyle.forCategory('Something Unrecognized');
      expect(visual, isNotNull);
    });
  });
}
