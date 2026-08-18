/// Finds the "source phrase that triggered the extraction" (Issue
/// #228's own `indicator` field, e.g. "The system shall...") — the
/// first requirement-style modal verb in the sentence, or null if none
/// is present (this sentence isn't a requirement candidate).
class FindRequirementIndicator {
  static const _modalKeywords = ['shall', 'must', 'should', 'will', 'is required to'];

  static String? call(String sentence) {
    final lower = sentence.toLowerCase();
    for (final keyword in _modalKeywords) {
      if (RegExp(r'\b' + keyword.replaceAll(' ', r'\s+') + r'\b').hasMatch(lower)) {
        return keyword;
      }
    }
    return null;
  }
}
