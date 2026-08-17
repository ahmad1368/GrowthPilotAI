import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/welcome_back_summary.dart';

/// Builds the "Welcome Back" banner content (Issue #214) from real local
/// data captured since [lastActiveAt] — [insightsSentSince] comes from
/// [RecommendationLogRepository.sentSince] (Issue #75).
class BuildWelcomeBackSummary {
  static WelcomeBackSummary call({
    required DateTime lastActiveAt,
    required DateTime now,
    required List<TransactionEntity> allTransactions,
    required List<DateTime> insightsSentSince,
  }) {
    final newTransactions =
        allTransactions.where((t) => t.date.isAfter(lastActiveAt)).length;

    return WelcomeBackSummary(
      daysAway: now.difference(lastActiveAt).inDays,
      newTransactionsCount: newTransactions,
      newInsightsCount: insightsSentSince.length,
    );
  }
}
