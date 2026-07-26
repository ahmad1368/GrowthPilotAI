import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_inventory_category_path.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';

void main() {
  test('a top-level category returns just its own name', () {
    final category = InventoryCategoryEntity(name: 'Bakery');
    expect(BuildInventoryCategoryPath.call(category), 'Bakery');
  });

  test('a nested category returns a parent > child breadcrumb', () {
    final parent = InventoryCategoryEntity(name: 'Bakery');
    final child = InventoryCategoryEntity(name: 'Bread')..parent.target = parent;

    expect(BuildInventoryCategoryPath.call(child), 'Bakery > Bread');
  });

  test('a 3-level chain joins in root-to-leaf order', () {
    final root = InventoryCategoryEntity(name: 'Bakery');
    final mid = InventoryCategoryEntity(name: 'Bread')..parent.target = root;
    final leaf = InventoryCategoryEntity(name: 'Sourdough')..parent.target = mid;

    expect(BuildInventoryCategoryPath.call(leaf), 'Bakery > Bread > Sourdough');
  });

  test('a cyclical parent chain does not loop forever', () {
    final a = InventoryCategoryEntity(name: 'A');
    final b = InventoryCategoryEntity(name: 'B')..parent.target = a;
    a.parent.target = b;

    expect(() => BuildInventoryCategoryPath.call(a), returnsNormally);
  });
}
