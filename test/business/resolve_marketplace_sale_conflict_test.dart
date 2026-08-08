import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_marketplace_sale_conflict.dart';

void main() {
  test('the earliest sale wins; the rest are conflicts', () {
    final result = ResolveMarketplaceSaleConflict.call([
      (providerName: 'Amazon', soldAt: DateTime(2026, 1, 1, 12, 0, 5)),
      (providerName: 'eBay', soldAt: DateTime(2026, 1, 1, 12, 0, 0)),
    ]);

    expect(result.winner, 'eBay');
    expect(result.conflicts, ['Amazon']);
  });

  test('a single sale has no conflicts', () {
    final result = ResolveMarketplaceSaleConflict.call([
      (providerName: 'eBay', soldAt: DateTime(2026, 1, 1)),
    ]);

    expect(result.winner, 'eBay');
    expect(result.conflicts, isEmpty);
  });
}
