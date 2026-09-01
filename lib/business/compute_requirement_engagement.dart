import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Stakeholder Engagement" (Issue #236) — the local proxy: the
/// fraction of requirements assigned a real stakeholder (Issue #229's
/// override dropdown) rather than left as 'Unassigned'. This repo has
/// no `stakeholders` table distinguishing "Project Team" from
/// "External Stakeholders", so it can't exclude the BA's own activity
/// the way the issue's DB note asks (see PR notes).
class ComputeRequirementEngagement {
  static const _unassigned = 'Unassigned';

  static double call(List<ExtractedRequirement> requirements) {
    if (requirements.isEmpty) return 0;
    final engaged = requirements.where((r) => r.stakeholder != _unassigned).length;
    return engaged / requirements.length;
  }
}
