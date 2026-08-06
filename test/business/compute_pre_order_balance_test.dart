import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_pre_order_balance.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';

void main() {
  final catalogItem = SeasonalCatalogItemEntity(
    id: 1,
    supplierName: 'Supplier',
    productName: 'Holiday Gift Sets',
    productDescription: '',
    unitPrice: 10.0,
    depositPercent: 0.25,
    deliveryWindowStart: DateTime(2026, 12, 1),
    listedAt: DateTime(2026, 1, 1),
  );

  test('applies the sliding-scale discount before splitting deposit/balance', () {
    final result = ComputePreOrderBalance.call(catalogItem, 20); // 10% tier
    expect(result.totalCost, closeTo(180.0, 0.001)); // 20 * 10 * 0.9
    expect(result.depositAmount, closeTo(45.0, 0.001)); // 180 * 0.25
    expect(result.balanceDue, closeTo(135.0, 0.001));
  });

  test('small quantities pay full price with no discount', () {
    final result = ComputePreOrderBalance.call(catalogItem, 3);
    expect(result.totalCost, closeTo(30.0, 0.001));
    expect(result.depositAmount, closeTo(7.5, 0.001));
    expect(result.balanceDue, closeTo(22.5, 0.001));
  });
}
