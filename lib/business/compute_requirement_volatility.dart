import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "volatility_rate: tracking how often requirements change over time"
/// (Issue #233) — the local proxy: the fraction of extracted
/// requirements the analyst has moved away from their AI-original
/// `pending` state. Not a real time-series (no successive-version
/// history via `LEAD`/`LAG` window functions exists here; see PR
/// notes).
class ComputeRequirementVolatility {
  static double call(List<ExtractedRequirement> requirements) {
    if (requirements.isEmpty) return 0;
    final touched =
        requirements.where((r) => r.status != RequirementTriageStatus.pending).length;
    return touched / requirements.length;
  }
}
