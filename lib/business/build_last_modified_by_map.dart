import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// The "Last Modified By" column value for every requirement (Issue
/// #245's XLSX/#247's CSV/#250's combined share) — the most recent
/// audit-log entry's `changedBy`, or `'local-user'` if none exists.
class BuildLastModifiedByMap {
  static Map<int, String> call(
      List<TraceableRequirementEntity> requirements, RequirementHistoryRepository historyRepository) {
    return {
      for (final r in requirements)
        r.id: _lastModifiedBy(r.id, historyRepository),
    };
  }

  static String _lastModifiedBy(int requirementId, RequirementHistoryRepository historyRepository) {
    final history = historyRepository.forRequirement(requirementId);
    return history.isEmpty ? 'local-user' : history.first.changedBy;
  }
}
