/// Resolves simple relative delivery-date language to an absolute date
/// (Issue #152) — real calendar-NLP is out of reach without an LLM, so
/// only a small fixed vocabulary is understood.
class ExtractDeliveryDateTerm {
  static DateTime? call(String content, DateTime now) {
    final lower = content.toLowerCase();
    if (lower.contains('today')) return DateTime(now.year, now.month, now.day);
    if (lower.contains('tomorrow')) {
      final d = now.add(const Duration(days: 1));
      return DateTime(d.year, d.month, d.day);
    }
    if (lower.contains('next week')) {
      final d = now.add(const Duration(days: 7));
      return DateTime(d.year, d.month, d.day);
    }
    return null;
  }
}
