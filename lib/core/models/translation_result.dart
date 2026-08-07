/// Outcome of one on-device translation pass (Issue #430) —
/// [matchedWordCount]/[totalWordCount] let the caller compute an
/// honest confidence signal instead of asserting perfect accuracy.
class TranslationResult {
  final String translatedText;
  final int matchedWordCount;
  final int totalWordCount;

  const TranslationResult({
    required this.translatedText,
    required this.matchedWordCount,
    required this.totalWordCount,
  });
}
