import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

/// The platform's graduated commission rate for each band (Issue
/// #425, acceptance criterion 1): 0.02% up to 100 transactions, 0.01%
/// up to 1,000, and 0.05% beyond 10,000.
class CommissionRateForTierBand {
  static const upTo100Rate = 0.0002;
  static const upTo1000Rate = 0.0001;
  static const over10000Rate = 0.0005;

  static double call(CommissionTierBand band) => switch (band) {
        CommissionTierBand.upTo100 => upTo100Rate,
        CommissionTierBand.upTo1000 => upTo1000Rate,
        CommissionTierBand.over10000 => over10000Rate,
      };
}
