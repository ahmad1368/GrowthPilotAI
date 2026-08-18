import 'package:growth_pilot_ai/business/classify_requirement_priority.dart';
import 'package:growth_pilot_ai/business/classify_requirement_type.dart';
import 'package:growth_pilot_ai/business/find_requirement_indicator.dart';
import 'package:growth_pilot_ai/business/split_text_into_sentence_spans.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// The local "Semantic Requirement Extraction" engine (Issue #228) — a
/// rule-based pipeline (sentence -> indicator match -> type/priority
/// classification), not LangChain's `create_extraction_chain` against a
/// real LLM (no LLM backend exists in this repo; see PR notes). A
/// sentence with no requirement-style modal verb is simply not a
/// candidate — this deliberately favors missing a real requirement over
/// the issue's own worry of "the AI thinks every sentence is a
/// requirement."
class ExtractRequirementsFromText {
  static List<ExtractedRequirement> call(String sanitizedText) {
    final spans = SplitTextIntoSentenceSpans.call(sanitizedText);
    final requirements = <ExtractedRequirement>[];

    for (final span in spans) {
      final indicator = FindRequirementIndicator.call(span.text);
      if (indicator == null) continue;

      requirements.add(ExtractedRequirement(
        description: span.text,
        type: ClassifyRequirementType.call(span.text),
        indicator: indicator,
        priorityHint: ClassifyRequirementPriority.call(span.text),
        startIndex: span.start,
        endIndex: span.end,
      ));
    }
    return requirements;
  }
}
