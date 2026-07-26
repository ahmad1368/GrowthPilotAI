import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';

/// Filters out archived suppliers and sorts alphabetically (Issue #442),
/// so the item-association picker and directory list don't surface
/// archived vendors that shouldn't take on new work.
class ComputeActiveSuppliers {
  static List<VendorEntity> call(List<VendorEntity> vendors) {
    final active = vendors.where((v) => v.isActive).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return active;
  }
}
