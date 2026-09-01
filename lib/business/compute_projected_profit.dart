import 'package:growth_pilot_ai/core/enum/action_impact_status.dart';
import 'package:growth_pilot_ai/core/models/action_impact_item.dart';

/// "Impact Forecasting" (Issue #260): projected profit growth if every
/// not-yet-done item on the roadmap were completed — the sum of
/// [ActionImpactItem.estimatedProfit] for todo/doing items. A simplified,
/// non-charted stand-in for the issue's "visual charts" (see PR notes).
class ComputeProjectedProfit {
  static double call(List<ActionImpactItem> items) {
    return items
        .where((item) => item.status != ActionImpactStatus.done)
        .fold<double>(0, (sum, item) => sum + item.estimatedProfit);
  }
}
