import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/canadian_business_categories.dart';

/// Covers Issue #826: sanity checks on the business-type dropdown data —
/// duplicate ids anywhere here would silently break DropdownButtonFormField
/// (Flutter throws on duplicate item values).
void main() {
  test('every parent category id is unique', () {
    final ids = canadianBusinessCategories.map((c) => c.id).toList();
    expect(ids.toSet().length, ids.length);
  });

  test('every category has at least one subcategory', () {
    for (final category in canadianBusinessCategories) {
      expect(category.children, isNotEmpty, reason: '${category.id} has no children');
    }
  });

  test('subcategory ids are unique within their parent', () {
    for (final category in canadianBusinessCategories) {
      final childIds = category.children.map((s) => s.id).toList();
      expect(childIds.toSet().length, childIds.length,
          reason: '${category.id} has duplicate subcategory ids');
    }
  });
}
