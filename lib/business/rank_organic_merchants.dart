import 'package:growth_pilot_ai/business/compute_merchant_rank_score.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';

/// Ranks the merchant directory (#338) by organic score, highest first
/// (Issue #408, acceptance criterion 1). Ranks are left unassigned
/// (0) here — [BuildLeaderboard] numbers rows after placing sponsored
/// entries above these.
class RankOrganicMerchants {
  static List<LeaderboardEntry> call(List<MerchantConfigEntity> configs) {
    final scored = configs
        .map((c) => (config: c, score: ComputeMerchantRankScore.call(c)))
        .toList()
      ..sort((a, b) => b.score.compareTo(a.score));

    return scored
        .map((entry) => LeaderboardEntry(
              rank: 0,
              name: entry.config.businessName,
              score: entry.score,
              isSponsored: false,
            ))
        .toList();
  }
}
