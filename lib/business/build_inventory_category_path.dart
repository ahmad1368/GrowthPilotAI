import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';

/// Builds a "Parent > Child" breadcrumb string for a hierarchical inventory
/// category (Issue #436). Guards against a corrupt/cyclical parent chain by
/// capping the walk depth.
class BuildInventoryCategoryPath {
  static const _maxDepth = 20;

  static String call(InventoryCategoryEntity category) {
    final segments = <String>[category.name];
    var current = category.parent.target;
    var depth = 0;
    while (current != null && depth < _maxDepth) {
      segments.add(current.name);
      current = current.parent.target;
      depth++;
    }
    return segments.reversed.join(' > ');
  }
}
