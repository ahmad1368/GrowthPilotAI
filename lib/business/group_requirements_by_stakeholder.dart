import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Stakeholders View" (Issue #229) — groups requirements by their
/// (possibly overridden) stakeholder field.
class GroupRequirementsByStakeholder {
  static Map<String, List<ExtractedRequirement>> call(List<ExtractedRequirement> requirements) {
    final groups = <String, List<ExtractedRequirement>>{};
    for (final requirement in requirements) {
      groups.putIfAbsent(requirement.stakeholder, () => []).add(requirement);
    }
    return groups;
  }
}
