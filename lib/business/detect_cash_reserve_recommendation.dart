import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';
import 'package:growth_pilot_ai/core/models/smart_recommendation.dart';

/// "Cash Reserve Alert" trigger (Issue #75): suggests moving excess cash to
/// a business savings account once the balance covers more than
/// [_reserveMultiplier] months of average expenses.
class DetectCashReserveRecommendation {
  static const double _reserveMultiplier = 3.0;

  static SmartRecommendation? call({
    required double balance,
    required double avgMonthlyExpenses,
  }) {
    if (avgMonthlyExpenses <= 0) return null;
    if (balance <= avgMonthlyExpenses * _reserveMultiplier) return null;

    final excess = balance - avgMonthlyExpenses * _reserveMultiplier;
    return SmartRecommendation(
      type: RecommendationType.cashReserve,
      title: 'Potential Savings Found',
      body: 'Your balance covers more than $_reserveMultiplier months of '
          'expenses. Consider moving \$${excess.toStringAsFixed(2)} to a '
          'high-interest business savings account.',
      actionLabel: 'View Cash Flow',
    );
  }
}
