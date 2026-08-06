import 'package:growth_pilot_ai/business/compute_sliding_scale_discount.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';

/// Prices one reservation quantity against its catalog line's unit
/// price, sliding-scale discount, and deposit percentage (Issue
/// #417, acceptance criteria 1-2 and 5) — shared by [ReservePreOrder]
/// and the balance-due display.
class ComputePreOrderBalance {
  static ({double totalCost, double depositAmount, double balanceDue}) call(
      SeasonalCatalogItemEntity catalogItem, int quantity) {
    final discount = ComputeSlidingScaleDiscount.call(quantity);
    final effectiveUnitPrice = catalogItem.unitPrice * (1 - discount);
    final totalCost = quantity * effectiveUnitPrice;
    final depositAmount = totalCost * catalogItem.depositPercent;
    return (totalCost: totalCost, depositAmount: depositAmount, balanceDue: totalCost - depositAmount);
  }
}
