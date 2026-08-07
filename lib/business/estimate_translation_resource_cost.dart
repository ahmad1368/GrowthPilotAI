import 'package:growth_pilot_ai/core/models/translation_resource_cost.dart';

/// Estimates the on-device processing cost of a dictionary-lookup
/// translation (Issue #430, acceptance criterion 5) — cost scales
/// linearly with word count since that's exactly how
/// [TranslateMessageOnDevice] executes, reflecting the real,
/// negligible footprint of a dictionary-based (vs. neural-model)
/// on-device translator.
class EstimateTranslationResourceCost {
  static const microsecondsPerWord = 50;
  static const bytesPerWord = 64;

  static TranslationResourceCost call(int wordCount) {
    return TranslationResourceCost(
      processingMicroseconds: wordCount * microsecondsPerWord,
      estimatedMemoryBytes: wordCount * bytesPerWord,
    );
  }
}
