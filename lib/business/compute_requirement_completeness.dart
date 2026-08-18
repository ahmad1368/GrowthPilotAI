import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Completeness" (Issue #236) — the local proxy for `approved_
/// requirements_count / total_requirements`: the fraction of extracted
/// requirements an analyst has confirmed.
class ComputeRequirementCompleteness {
  static double call(List<ExtractedRequirement> requirements) {
    if (requirements.isEmpty) return 0;
    final confirmed =
        requirements.where((r) => r.status == RequirementTriageStatus.confirmed).length;
    return confirmed / requirements.length;
  }
}
