import 'package:growth_pilot_ai/core/data/entities/market_snapshot_entity.dart';
import 'package:growth_pilot_ai/core/models/trend_point.dart';

/// "Historical Trend Pipeline" (Issue #102 scope item 4): the last 30
/// days of a peer group's snapshots, sorted oldest-first and mapped to
/// `{date, value}` points. Pure — the caller fetches [snapshots] via
/// [MarketSnapshotRepository.getForPeerGroup] first.
class GetPriceTrend {
  static const window = Duration(days: 30);

  static List<TrendPoint> call(List<MarketSnapshotEntity> snapshots, DateTime now) {
    final cutoff = now.subtract(window);
    final inWindow = snapshots.where((s) => !s.snapshotDate.isBefore(cutoff)).toList()
      ..sort((a, b) => a.snapshotDate.compareTo(b.snapshotDate));
    return inWindow.map((s) => TrendPoint(date: s.snapshotDate, value: s.avgPrice)).toList();
  }
}
