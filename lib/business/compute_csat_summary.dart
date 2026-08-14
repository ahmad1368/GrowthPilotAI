import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';
import 'package:growth_pilot_ai/core/models/csat_summary.dart';

/// Aggregates manually-logged CSAT ratings into an average score and a
/// simple recent-vs-earlier trend read (Issue #375) — this app has no
/// post-purchase survey backend, so ratings are logged manually the same
/// way [WasteLogEntity] entries are.
class ComputeCsatSummary {
  static CsatSummary call(List<CsatRatingEntity> ratings) {
    if (ratings.isEmpty) {
      return const CsatSummary(averageScore: 0, totalRatings: 0, trendDelta: 0);
    }

    final sorted = [...ratings]..sort((a, b) => a.date.compareTo(b.date));
    final averageScore = _average(sorted);

    final mid = sorted.length ~/ 2;
    final trendDelta =
        mid == 0 ? 0.0 : _average(sorted.sublist(mid)) - _average(sorted.sublist(0, mid));

    return CsatSummary(
      averageScore: averageScore,
      totalRatings: sorted.length,
      trendDelta: trendDelta,
    );
  }

  static double _average(List<CsatRatingEntity> ratings) =>
      ratings.fold<double>(0, (sum, r) => sum + r.score) / ratings.length;
}
