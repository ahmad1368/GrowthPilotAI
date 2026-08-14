import 'package:growth_pilot_ai/core/models/payment_method_breakdown.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One-sentence read on total estimated processing-fee drag (Issue #391).
class BuildPaymentFeeNarrative {
  static String call(List<PaymentMethodBreakdown> breakdowns) {
    if (breakdowns.isEmpty) {
      return 'Not enough payment history yet to compare channels.';
    }
    final totalFees =
        breakdowns.fold<double>(0, (sum, b) => sum + b.estimatedProcessingFees);
    if (totalFees <= 0) {
      return 'No processing-fee drag detected across recorded payment channels.';
    }
    final leader = breakdowns.first;
    return '${CurrencyFormat.cad(totalFees)} in estimated processing fees so far — '
        '${leader.method.name} is your top payment channel by volume.';
  }
}
