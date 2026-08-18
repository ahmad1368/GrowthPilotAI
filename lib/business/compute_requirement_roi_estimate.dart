import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "ROI Estimation: estimates project value based on the density of
/// business-critical requirements" (Issue #233) — Must-Have counts
/// fully, Should-Have counts at half weight, normalized to `[0, 1]`.
class ComputeRequirementRoiEstimate {
  static double call(List<ExtractedRequirement> requirements) {
    if (requirements.isEmpty) return 0;
    final weighted = requirements.fold<double>(0, (sum, r) => sum + _weightFor(r.moscowPriority));
    return weighted / requirements.length;
  }

  static double _weightFor(RequirementMoscowPriority priority) {
    switch (priority) {
      case RequirementMoscowPriority.mustHave:
        return 1;
      case RequirementMoscowPriority.shouldHave:
        return 0.5;
      case RequirementMoscowPriority.couldHave:
      case RequirementMoscowPriority.wontHave:
        return 0;
    }
  }
}
