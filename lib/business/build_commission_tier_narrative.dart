import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';

/// One-sentence, rule-based summary of a commission-tier settlement
/// (Issue #425, acceptance criterion 3) — used both on-screen and as
/// the audit-log justification for the applied rate.
class BuildCommissionTierNarrative {
  static String call(CommissionTierRecordEntity record) {
    if (!record.dependencyVerified) {
      return '${record.merchantName} is on the standard rate until dependency '
          'verification (Issue #424) completes.';
    }
    final pct = (record.commissionRate * 100).toStringAsFixed(2);
    final overrideNote = record.isOverridden ? ' (admin override)' : '';
    return '${record.merchantName}: ${record.cumulativeTransactionCount} cumulative orders → '
        '${record.tierBand.name} tier at $pct% commission '
        '(\$${record.commissionAmount.toStringAsFixed(2)})$overrideNote.';
  }
}
