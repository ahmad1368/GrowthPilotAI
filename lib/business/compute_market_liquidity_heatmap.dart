import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/procurement_request_status.dart';

/// "Market Liquidity Heatmap" (Issue #129) — Active (open) vs Completed
/// (accepted) request counts per neighborhood, to spot supply gaps.
class ComputeMarketLiquidityHeatmap {
  static List<({String neighborhood, int active, int completed})> call(
      List<ProcurementRequestEntity> requests) {
    final byNeighborhood = <String, ({int active, int completed})>{};
    for (final r in requests) {
      final current = byNeighborhood[r.neighborhood] ?? (active: 0, completed: 0);
      byNeighborhood[r.neighborhood] = (
        active: current.active + (r.status == ProcurementRequestStatus.open ? 1 : 0),
        completed: current.completed + (r.status == ProcurementRequestStatus.accepted ? 1 : 0),
      );
    }
    return byNeighborhood.entries
        .map((e) => (neighborhood: e.key, active: e.value.active, completed: e.value.completed))
        .toList();
  }
}
