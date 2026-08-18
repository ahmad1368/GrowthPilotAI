import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Priority Matrix" (Issue #229) — groups requirements by their
/// (possibly overridden) MoSCoW priority, always including every tier
/// (even empty ones) so the matrix has a stable, complete layout.
class GroupRequirementsByPriority {
  static Map<RequirementMoscowPriority, List<ExtractedRequirement>> call(
      List<ExtractedRequirement> requirements) {
    final groups = {for (final p in RequirementMoscowPriority.values) p: <ExtractedRequirement>[]};
    for (final requirement in requirements) {
      groups[requirement.moscowPriority]!.add(requirement);
    }
    return groups;
  }
}
