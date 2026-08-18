import 'package:growth_pilot_ai/core/enum/requirement_priority_hint.dart';

/// Suggests a priority "based on the language used" (Issue #228's own
/// `priority_hint` schema) — keyword heuristics, not an LLM judgment
/// (see PR notes).
class ClassifyRequirementPriority {
  static const _highKeywords = ['critical', 'mandatory', 'must', 'shall'];
  static const _lowKeywords = ['may', 'optional', 'could', 'nice to have'];

  static RequirementPriorityHint call(String sentence) {
    final lower = sentence.toLowerCase();
    if (_highKeywords.any(lower.contains)) return RequirementPriorityHint.high;
    if (_lowKeywords.any(lower.contains)) return RequirementPriorityHint.low;
    return RequirementPriorityHint.medium;
  }
}
