import '../../../../objectbox.g.dart';
import '../entities/requirement_history_entity.dart';

/// Append-only ObjectBox wrapper for [RequirementHistoryEntity] rows
/// (Issue #238) — no update/delete exposed, same WORM pattern as this
/// repo's #186 `SecurityAuditLogRepository`.
class RequirementHistoryRepository {
  final Box<RequirementHistoryEntity> _box;

  RequirementHistoryRepository(this._box);

  void append(RequirementHistoryEntity entry) => _box.put(entry);

  /// Newest first, for the "History Timeline" widget.
  List<RequirementHistoryEntity> forRequirement(int requirementId) {
    return _box.getAll().where((e) => e.requirement.targetId == requirementId).toList()
      ..sort((a, b) => b.changedAt.compareTo(a.changedAt));
  }
}
