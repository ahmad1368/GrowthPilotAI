import 'package:growth_pilot_ai/business/group_requirements_by_stakeholder.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Priority Matrix: a Bar chart (Stacked) showing the distribution of
/// MoSCoW priorities across different stakeholders" (Issue #234) —
/// built on top of Issue #229's [GroupRequirementsByStakeholder].
class GroupRequirementsByStakeholderAndPriority {
  static Map<String, Map<RequirementMoscowPriority, int>> call(
      List<ExtractedRequirement> requirements) {
    final byStakeholder = GroupRequirementsByStakeholder.call(requirements);
    return {
      for (final entry in byStakeholder.entries)
        entry.key: {
          for (final priority in RequirementMoscowPriority.values)
            priority: entry.value.where((r) => r.moscowPriority == priority).length,
        },
    };
  }
}
