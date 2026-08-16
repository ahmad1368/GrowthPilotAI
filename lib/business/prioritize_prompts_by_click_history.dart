import 'package:growth_pilot_ai/core/data/entities/prompt_click_entity.dart';

/// Reorders [prompts] to put the user's most-clicked ones first (Issue
/// #201's "Frequency Tracking... to prioritize [prompts] in the
/// future") — a prompt with no click history keeps its original
/// relative order among other never-clicked prompts.
class PrioritizePromptsByClickHistory {
  static List<String> call(List<String> prompts, List<PromptClickEntity> history) {
    final clickCounts = {for (final h in history) h.promptText: h.clickCount};
    final sorted = [...prompts]
      ..sort((a, b) => (clickCounts[b] ?? 0).compareTo(clickCounts[a] ?? 0));
    return sorted;
  }
}
