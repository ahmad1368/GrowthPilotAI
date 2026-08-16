import 'package:growth_pilot_ai/business/build_location_prompt.dart';
import 'package:growth_pilot_ai/business/build_quick_prompts.dart';
import 'package:growth_pilot_ai/business/build_seasonal_prompt.dart';
import 'package:growth_pilot_ai/business/build_top_category_prompt.dart';

/// Combines every signal source into the Quick Action chip list (Issue
/// #201) — seasonal + anomaly/top-category + location, topped up with
/// the issue's own "Safe" static fallback and #200's screen-aware
/// prompts, deduplicated and capped to 4 (AC: "3-4 Chips").
class BuildDynamicQuickPrompts {
  static const _staticFallback = 'Total GST/HST collected this year';

  static List<String> call({
    required DateTime now,
    required String screenId,
    String? topCategory,
    double? percentChangeVsLastMonth,
    String? topCity,
  }) {
    final seasonal = BuildSeasonalPrompt.call(now);
    final category = BuildTopCategoryPrompt.call(
        topCategory: topCategory, percentChangeVsLastMonth: percentChangeVsLastMonth);
    final location = BuildLocationPrompt.call(topCity);

    final prompts = <String>{
      if (seasonal != null) seasonal,
      if (category != null) category,
      if (location != null) location,
      _staticFallback,
      ...BuildQuickPrompts.call(screenId),
    };
    return prompts.take(4).toList();
  }
}
