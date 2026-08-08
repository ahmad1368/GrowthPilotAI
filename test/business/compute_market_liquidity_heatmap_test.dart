import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_market_liquidity_heatmap.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  ProcurementRequestEntity request(String neighborhood, ProcurementRequestStatus status) =>
      ProcurementRequestEntity(
          requesterId: 'buyer', sector: 'auto', summary: 's', budgetMin: 0, budgetMax: 0,
          centerLat: 0, centerLng: 0, radiusKm: 1, neighborhood: neighborhood,
          deadline: now.add(const Duration(days: 1)), createdAt: now)
        ..status = status;

  test('splits active vs completed per neighborhood', () {
    final result = ComputeMarketLiquidityHeatmap.call([
      request('Whalley', ProcurementRequestStatus.open),
      request('Whalley', ProcurementRequestStatus.accepted),
      request('Guildford', ProcurementRequestStatus.open),
    ]);

    final whalley = result.firstWhere((r) => r.neighborhood == 'Whalley');
    expect(whalley.active, 1);
    expect(whalley.completed, 1);

    final guildford = result.firstWhere((r) => r.neighborhood == 'Guildford');
    expect(guildford.active, 1);
    expect(guildford.completed, 0);
  });
}
