import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/traceability_quick_filter.dart';

/// Applies one "Quick Filter Chip" (Issue #239) — `null` means no
/// filter is active (returns [requirements] unchanged).
class FilterRequirementsByQuickFilter {
  static List<TraceableRequirementEntity> call(
    List<TraceableRequirementEntity> requirements,
    TraceabilityQuickFilter? filter, {
    required Set<int> requirementIdsWithoutGoal,
    required Set<int> requirementIdsWithoutTestCase,
  }) {
    switch (filter) {
      case TraceabilityQuickFilter.gapsOnly:
        return requirements.where((r) => requirementIdsWithoutGoal.contains(r.id)).toList();
      case TraceabilityQuickFilter.untestedReqs:
        return requirements.where((r) => requirementIdsWithoutTestCase.contains(r.id)).toList();
      case TraceabilityQuickFilter.highPriority:
        return requirements.where((r) => r.moscowPriority == RequirementMoscowPriority.mustHave).toList();
      case null:
        return requirements;
    }
  }
}
