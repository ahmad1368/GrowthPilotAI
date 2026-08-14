import '../../../objectbox.g.dart';
import 'package:growth_pilot_ai/core/data/entities/recommendation_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';

/// Thin ObjectBox wrapper for Smart Recommendation send history (Issue #75):
/// backs [CapRecommendationFrequency] and the conversion-rate tracker.
class RecommendationLogRepository {
  final Box<RecommendationLogEntity> _box;

  RecommendationLogRepository(this._box);

  List<DateTime> sentSince(DateTime since) {
    final query = _box
        .query(RecommendationLogEntity_.sentAt
            .greaterThan(since.millisecondsSinceEpoch))
        .build();
    final results = query.find().map((e) => e.sentAt).toList();
    query.close();
    return results;
  }

  int upsert(RecommendationLogEntity entity) => _box.put(entity);

  /// Marks the most recent un-acted log of [type] as converted (the user
  /// tapped the card's primary action rather than dismissing/snoozing it).
  void markMostRecentActedOn(RecommendationType type) {
    final entries = _box.getAll().where((e) => e.type == type && !e.actedOn).toList()
      ..sort((a, b) => b.sentAt.compareTo(a.sentAt));
    if (entries.isEmpty) return;
    entries.first.actedOn = true;
    _box.put(entries.first);
  }

  /// Fraction of sent [type] recommendations the user acted on (0 when none
  /// have been sent yet).
  double conversionRate(RecommendationType type) {
    final entries = _box.getAll().where((e) => e.type == type).toList();
    if (entries.isEmpty) return 0.0;
    return entries.where((e) => e.actedOn).length / entries.length;
  }
}
