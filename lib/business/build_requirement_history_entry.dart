import 'package:growth_pilot_ai/core/data/entities/requirement_history_entity.dart';
import 'package:growth_pilot_ai/core/enum/requirement_change_type.dart';

/// Builds one audit row for [RequirementHistoryRepository.append]
/// (Issue #238) — `changedBy` is always `'local-user'`, since no auth
/// identity system for this feature exists in this repo (see PR
/// notes).
class BuildRequirementHistoryEntry {
  static RequirementHistoryEntity call({
    required int requirementId,
    required RequirementChangeType type,
    String? oldValue,
    String? newValue,
    required String reason,
  }) {
    return RequirementHistoryEntity(
      dbChangeType: type.index,
      changedAt: DateTime.now(),
      changedBy: 'local-user',
      oldValue: oldValue,
      newValue: newValue,
      reasonForChange: reason,
    )..requirement.targetId = requirementId;
  }
}
