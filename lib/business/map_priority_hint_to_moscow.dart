import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_priority_hint.dart';

/// Maps #228's local `high`/`medium`/`low` heuristic onto Issue #229's
/// MoSCoW scale — [RequirementMoscowPriority.wontHave] is never
/// auto-assigned; a rule-based extractor has no signal for "this was
/// considered and explicitly declined," so it's reachable only via the
/// AC's "Manual Override" dropdown.
class MapPriorityHintToMoscow {
  static RequirementMoscowPriority call(RequirementPriorityHint hint) {
    switch (hint) {
      case RequirementPriorityHint.high:
        return RequirementMoscowPriority.mustHave;
      case RequirementPriorityHint.medium:
        return RequirementMoscowPriority.shouldHave;
      case RequirementPriorityHint.low:
        return RequirementMoscowPriority.couldHave;
    }
  }
}
