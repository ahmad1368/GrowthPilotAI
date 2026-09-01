import 'package:growth_pilot_ai/core/models/merchant_partnership_value.dart';

/// One-sentence read naming the best logged partnership (Issue #393).
class BuildMerchantPartnershipNarrative {
  static String call(List<MerchantPartnershipValue> results) {
    if (results.isEmpty) {
      return 'No partnerships logged yet — add one to start tracking collaborative value.';
    }
    final best = results.first;
    if (results.length == 1) {
      return best.isHighValue
          ? '${best.partnerBusinessName} is a high-synergy partner generating \$${best.jointCampaignRevenue.toStringAsFixed(0)} in joint revenue.'
          : '${best.partnerBusinessName} has modest overlap so far — keep tracking joint campaigns.';
    }
    return '${best.partnerBusinessName} is your top collaborative partner at \$${best.jointCampaignRevenue.toStringAsFixed(0)} joint revenue '
        '(${best.synergyLevel.name} customer overlap).';
  }
}
