import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/build_dynamic_quick_prompts.dart';
import 'package:growth_pilot_ai/business/prioritize_prompts_by_click_history.dart';
import 'package:growth_pilot_ai/core/data/repositories/prompt_click_repository.dart';

/// Owns the Quick Action chip signals + click-frequency tracking (Issue
/// #201) for [AiChatController] — split out to keep that controller
/// focused on message/session state. None of [topCategory]/
/// [percentChangeVsLastMonth]/[topCity] are set from real transaction
/// data yet — see PR notes.
class QuickPromptsProvider {
  final Rx<String?> topCategory = Rx(null);
  final Rx<double?> percentChangeVsLastMonth = Rx(null);
  final Rx<String?> topCity = Rx(null);
  final PromptClickRepository _repository = GetIt.I<PromptClickRepository>();

  List<String> forScreen(String screenId) {
    final prompts = BuildDynamicQuickPrompts.call(
      now: DateTime.now(),
      screenId: screenId,
      topCategory: topCategory.value,
      percentChangeVsLastMonth: percentChangeVsLastMonth.value,
      topCity: topCity.value,
    );
    return PrioritizePromptsByClickHistory.call(prompts, _repository.getAll());
  }

  void recordClick(String prompt) => _repository.recordClick(prompt);
}
