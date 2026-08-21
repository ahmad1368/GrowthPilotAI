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
}
