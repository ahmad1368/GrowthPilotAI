import 'package:growth_pilot_ai/core/models/discount_campaign_impact.dart';

/// One-sentence read naming the most and least profitable logged discount
/// campaigns (Issue #362).
class BuildDiscountCampaignImpactNarrative {
  static String call(List<DiscountCampaignImpact> results) {
    if (results.isEmpty) {
      return 'No discount campaigns logged yet — add one to start tracking impact.';
    }
    if (results.length == 1) {
      final only = results.first;
      return only.isProfitable
          ? '${only.name} generated a net profit lift over baseline.'
          : '${only.name} cost more in discounts than it lifted sales.';
    }
    final best = results.first;
    final worst = results.last;
    return '${best.name} is your best performer over baseline — '
        '${worst.name} trails behind.';
  }
}
