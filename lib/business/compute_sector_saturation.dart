import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

/// "Sector Saturation" (Issue #129) — request volume per sector, most
/// active first.
class ComputeSectorSaturation {
  static List<({String sector, int count})> call(List<ProcurementRequestEntity> requests) {
    final counts = <String, int>{};
    for (final r in requests) {
      counts[r.sector] = (counts[r.sector] ?? 0) + 1;
    }
    final result = counts.entries.map((e) => (sector: e.key, count: e.value)).toList()
      ..sort((a, b) => b.count.compareTo(a.count));
    return result;
  }
}
