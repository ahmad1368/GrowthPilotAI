import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/enum/financial_dna_dimension.dart';
import 'package:growth_pilot_ai/core/enum/inbox_notification_type.dart';
import 'package:growth_pilot_ai/core/enum/notification_priority.dart';
import 'package:growth_pilot_ai/core/models/success_pattern_result.dart';

/// "Strategy Insight" card (Issue #83 scope item 2) — Positive
/// Reinforcement when the pattern matches, Course Correction with one
/// actionable tip when it doesn't. Always carries the AC's legal
/// disclaimer, since this is a statistical pattern match, not advice.
class BuildSuccessSignatureAlert {
  static const _disclaimer =
      'Past performance of sector leaders does not guarantee future results.';

  static const _tips = {
    FinancialDnaDimension.liquidityRatio:
        'building a stronger cash buffer relative to short-term liabilities',
    FinancialDnaDimension.burnVelocity: 'keeping expense growth closer to revenue growth',
    FinancialDnaDimension.vendorDiversity: 'diversifying your vendor base',
    FinancialDnaDimension.paymentPunctuality: 'paying invoices more promptly',
  };

  static InboxNotificationEntity call(String sectorName, SuccessPatternResult result, DateTime now) {
    final body = result.isHighGrowthMatch
        ? 'Your current spending and liquidity ratios match the top performers in the $sectorName sector. $_disclaimer'
        : 'Consider ${_tips[result.divergentDimension]} to align with $sectorName sector leaders. $_disclaimer';

    return InboxNotificationEntity(
      title: result.isHighGrowthMatch ? 'Pattern Matched: High-Growth' : 'Strategy Insight',
      body: body,
      dbType: InboxNotificationType.info.index,
      dbPriority: NotificationPriority.normal.index,
      createdAt: now,
    );
  }
}
