import 'package:growth_pilot_ai/core/models/loyalty_program_effectiveness.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One-sentence verdict on whether the simulated loyalty program's
/// liability cost is justified by the repeat-buyer revenue it protects
/// (Issue #396).
class BuildLoyaltyProgramNarrative {
  static String call(LoyaltyProgramEffectiveness effectiveness) {
    if (effectiveness.pointsIssued <= 0) {
      return 'Not enough income history yet to simulate a loyalty program.';
    }
    final cost = CurrencyFormat.cad(effectiveness.liabilityCost);
    final repeatRevenue = CurrencyFormat.cad(effectiveness.repeatCustomerRevenue);
    if (effectiveness.isEffective) {
      return '$cost in points liability protects $repeatRevenue in repeat-buyer '
          'revenue — the program is paying for itself.';
    }
    return '$cost in points liability only protects $repeatRevenue in repeat-buyer '
        'revenue — reconsider the reward rate or targeting.';
  }
}
