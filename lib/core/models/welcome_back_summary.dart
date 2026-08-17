import 'package:flutter/foundation.dart';

/// "Welcome Back" banner content (Issue #214's "In-App Highlights: show
/// a summary of what they missed") — built from real local counts, never
/// a fabricated figure.
@immutable
class WelcomeBackSummary {
  final int daysAway;
  final int newTransactionsCount;
  final int newInsightsCount;

  const WelcomeBackSummary({
    required this.daysAway,
    required this.newTransactionsCount,
    required this.newInsightsCount,
  });

  bool get hasAnyUpdates => newTransactionsCount > 0 || newInsightsCount > 0;
}
