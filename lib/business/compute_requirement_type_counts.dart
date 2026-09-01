import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "requirement_count: Total, functional vs non-functional" (Issue
/// #233) — a full per-[RequirementType] tally.
class ComputeRequirementTypeCounts {
  static Map<RequirementType, int> call(List<ExtractedRequirement> requirements) {
    final counts = {for (final type in RequirementType.values) type: 0};
    for (final requirement in requirements) {
      counts[requirement.type] = (counts[requirement.type] ?? 0) + 1;
    }
    return counts;
  }
}
