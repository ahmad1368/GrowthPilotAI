import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

/// "Market Sentiment Engine" (Issue #148) — flags a sector as trending
/// when this week's request volume grows >=20% over the prior week (or
/// is a brand-new sector with meaningful activity).
class DetectTrendingSectors {
  static const growthThreshold = 0.2;
  static const newSectorMinCount = 2;

  static List<String> call(List<ProcurementRequestEntity> requests, DateTime now) {
    final currentStart = now.subtract(const Duration(days: 7));
    final previousStart = now.subtract(const Duration(days: 14));

    final current = <String, int>{};
    final previous = <String, int>{};
    for (final r in requests) {
      if (r.createdAt.isAfter(currentStart)) {
        current[r.sector] = (current[r.sector] ?? 0) + 1;
      } else if (r.createdAt.isAfter(previousStart)) {
        previous[r.sector] = (previous[r.sector] ?? 0) + 1;
      }
    }

    final trending = <String>[];
    current.forEach((sector, count) {
      final prior = previous[sector] ?? 0;
      if (prior == 0) {
        if (count >= newSectorMinCount) trending.add(sector);
        return;
      }
      if ((count - prior) / prior >= growthThreshold) trending.add(sector);
    });
    return trending;
  }
}
