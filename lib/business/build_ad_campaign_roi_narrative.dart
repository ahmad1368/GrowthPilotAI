import 'package:growth_pilot_ai/core/models/ad_campaign_roi.dart';

/// One-sentence read naming the best- and worst-ROI logged campaigns
/// (Issue #366).
class BuildAdCampaignRoiNarrative {
  static String call(List<AdCampaignRoi> results) {
    if (results.isEmpty) {
      return 'No campaigns logged yet — add one to start tracking ROI.';
    }
    if (results.length == 1) {
      final only = results.first;
      final pct = (only.roi * 100).toStringAsFixed(0);
      return '${only.name} returned $pct% ROI so far.';
    }
    final best = results.first;
    final worst = results.last;
    final bestPct = (best.roi * 100).toStringAsFixed(0);
    final worstPct = (worst.roi * 100).toStringAsFixed(0);
    return '${best.name} is your best performer at $bestPct% ROI — '
        '${worst.name} trails at $worstPct%.';
  }
}
