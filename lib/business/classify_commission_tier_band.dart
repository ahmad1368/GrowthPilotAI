import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

/// Maps a cumulative transaction count to its commission band (Issue
/// #425, acceptance criterion 1). The schedule only names bands at
/// 100, 1,000, and "exceeding 10,000" transactions — counts between
/// 1,001 and 10,000 continue at the 1,000-band rate until volume
/// actually exceeds 10,000, rather than inventing an unstated rate.
class ClassifyCommissionTierBand {
  static const tier1MaxCount = 100;
  static const tier2MaxCount = 1000;
  static const tier3ExceedsCount = 10000;

  static CommissionTierBand call(int cumulativeCount) {
    if (cumulativeCount > tier3ExceedsCount) return CommissionTierBand.over10000;
    if (cumulativeCount <= tier1MaxCount) return CommissionTierBand.upTo100;
    return CommissionTierBand.upTo1000;
  }
}
