/// Estimated on-device resource footprint of one translation (Issue
/// #430, acceptance criterion 5).
class TranslationResourceCost {
  final int processingMicroseconds;
  final int estimatedMemoryBytes;

  const TranslationResourceCost({
    required this.processingMicroseconds,
    required this.estimatedMemoryBytes,
  });
}
