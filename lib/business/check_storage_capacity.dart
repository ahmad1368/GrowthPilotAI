import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';

/// Whether a matched listing's quantity is within a sane restocking
/// ceiling for the item (Issue #418, acceptance criterion 5) — this
/// app has no shelf/warehouse capacity model, so storage headroom is
/// approximated as up to 3x the item's own reorder threshold, the
/// same order-of-magnitude heuristic [ComputeStockDepletionForecast]'s
/// critical-days window already uses for this feature area.
class CheckStorageCapacity {
  static bool call(WholesaleListingEntity listing, int reorderThreshold) {
    if (reorderThreshold <= 0) return true;
    return listing.quantityListed <= reorderThreshold * 3;
  }
}
