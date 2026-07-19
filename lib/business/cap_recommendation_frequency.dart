/// "Frequency Capping" guard (Issue #75): at most [maxPerWeek] Smart
/// Recommendation messages may be sent in any trailing 7-day window, so the
/// business owner isn't spammed.
class CapRecommendationFrequency {
  static const int _windowDays = 7;

  static bool canSend({
    required List<DateTime> recentSentAt,
    required DateTime now,
    int maxPerWeek = 2,
  }) {
    final windowStart = now.subtract(const Duration(days: _windowDays));
    final sentInWindow =
        recentSentAt.where((sentAt) => sentAt.isAfter(windowStart)).length;
    return sentInWindow < maxPerWeek;
  }
}
