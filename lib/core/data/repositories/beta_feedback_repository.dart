import '../../../../objectbox.g.dart';
import '../entities/beta_feedback_entity.dart';

/// Append-only ObjectBox wrapper for [BetaFeedbackEntity] rows (Issue
/// #191) — same WORM pattern as this repo's #250 `ExportEventRepository`.
class BetaFeedbackRepository {
  final Box<BetaFeedbackEntity> _box;

  BetaFeedbackRepository(this._box);

  void append(BetaFeedbackEntity feedback) => _box.put(feedback);

  /// Newest first.
  List<BetaFeedbackEntity> getAll() => _box.getAll()..sort((a, b) => b.submittedAt.compareTo(a.submittedAt));

  /// Same-calendar-day submission count for [businessId] (Issue #169
  /// AC: "Limit feedback submissions to 5 per user/day").
  int countSubmittedOn(String businessId, DateTime day) {
    return getAll().where((f) {
      final at = f.submittedAt;
      return f.businessId == businessId && at.year == day.year && at.month == day.month && at.day == day.day;
    }).length;
  }
}
