import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';
import 'package:growth_pilot_ai/core/models/smart_recommendation.dart';

/// "Tax Deadline (CRA)" trigger (Issue #75): within [_reminderWindowDays] of
/// a GST/HST filing deadline, reminds the user to verify any "Uncategorized"
/// transactions (Issue #59) before filing.
class DetectTaxDeadlineRecommendation {
  static const int _reminderWindowDays = 30;

  static SmartRecommendation? call({
    required int daysUntilGstDeadline,
    required int uncategorizedTransactionCount,
  }) {
    if (daysUntilGstDeadline < 0 ||
        daysUntilGstDeadline > _reminderWindowDays) {
      return null;
    }
    if (uncategorizedTransactionCount <= 0) return null;

    return SmartRecommendation(
      type: RecommendationType.taxDeadline,
      title: 'GST/HST Filing Deadline Approaching',
      body: 'Your filing is due in $daysUntilGstDeadline days and you have '
          '$uncategorizedTransactionCount uncategorized transactions. '
          'Review them now to avoid last-minute surprises.',
      actionLabel: 'Review Uncategorized',
    );
  }
}
