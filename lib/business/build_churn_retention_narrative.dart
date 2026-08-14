import 'package:growth_pilot_ai/core/models/churn_retention_snapshot.dart';

/// One-sentence, rule-based retention prompt (Issue #357) — not the
/// issue's literal automated SMS/email voucher dispatch, since this app
/// has no messaging/notification backend to send those from.
class BuildChurnRetentionNarrative {
  static String call(ChurnRetentionSnapshot snapshot) {
    if (snapshot.previousPeriodCount == 0 && snapshot.currentPeriodCount == 0) {
      return 'Not enough transaction history yet to measure retention.';
    }
    final pct = (snapshot.retentionRate * 100).toStringAsFixed(0);
    if (snapshot.isChurnRisk) {
      return 'Retention is at $pct% of the prior window — consider sending '
          'loyalty offers or discount vouchers to re-engage lapsing customers.';
    }
    return 'Retention is holding at $pct% of the prior window — no action needed.';
  }
}
