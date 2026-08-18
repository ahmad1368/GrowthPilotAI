import 'package:growth_pilot_ai/core/enum/requirement_type.dart';

/// Categorizes a requirement sentence (Issue #228's own `type` schema)
/// via keyword heuristics — a documented substitute for the issue's
/// LangChain/LLM classification (see PR notes: no LLM backend exists in
/// this repo). Checked most-specific-first: technical, then
/// non-functional, then business-rule; [RequirementType.functional] is
/// the fallback once an indicator (a modal verb) has already matched.
class ClassifyRequirementType {
  static const _technicalKeywords = ['api', 'database', 'integrat', 'protocol', 'endpoint'];
  static const _nonFunctionalKeywords = [
    'performance',
    'response time',
    'availability',
    'scalab',
    'security',
    'uptime',
  ];
  static const _businessRuleKeywords = ['policy', 'business rule', 'in accordance with', 'comply'];

  static RequirementType call(String sentence) {
    final lower = sentence.toLowerCase();
    if (_technicalKeywords.any(lower.contains)) return RequirementType.technical;
    if (_nonFunctionalKeywords.any(lower.contains)) return RequirementType.nonFunctional;
    if (_businessRuleKeywords.any(lower.contains)) return RequirementType.businessRule;
    return RequirementType.functional;
  }
}
