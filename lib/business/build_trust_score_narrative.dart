import 'package:growth_pilot_ai/core/enum/merchant_trust_tier.dart';
import 'package:growth_pilot_ai/core/models/merchant_trust_score.dart';

/// One-sentence read naming how many merchants qualify for the
/// automatic gold-tier discount privilege (Issue #347, acceptance
/// criterion 3).
class BuildTrustScoreNarrative {
  static String call(List<MerchantTrustScore> scores) {
    if (scores.isEmpty) {
      return 'No merchant profiles to score yet.';
    }
    final gold = scores.where((s) => s.tier == MerchantTrustTier.gold).length;
    if (gold == 0) {
      return 'No merchants have reached gold-tier trust yet.';
    }
    return '$gold of ${scores.length} merchant(s) reached gold-tier trust and '
        'automatically receive the commission discount.';
  }
}
