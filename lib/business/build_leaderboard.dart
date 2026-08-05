import 'package:growth_pilot_ai/business/rank_organic_merchants.dart';
import 'package:growth_pilot_ai/business/rank_sponsored_merchants.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';

/// Combines sponsored and organic rankings into the final numbered
/// leaderboard (Issue #408, acceptance criterion 2) — sponsored
/// entries are always pinned above organic ones regardless of score,
/// and a merchant already shown as sponsored isn't duplicated below.
class BuildLeaderboard {
  static List<LeaderboardEntry> call(
      List<MerchantConfigEntity> configs, List<AdvertisingRequestEntity> requests) {
    final sponsored = RankSponsoredMerchants.call(requests);
    final sponsoredNames = sponsored.map((e) => e.name).toSet();
    final organic = RankOrganicMerchants.call(configs)
        .where((e) => !sponsoredNames.contains(e.name))
        .toList();

    var rank = 1;
    return [
      for (final entry in [...sponsored, ...organic])
        LeaderboardEntry(
          rank: rank++,
          name: entry.name,
          score: entry.score,
          isSponsored: entry.isSponsored,
          sourceRequestId: entry.sourceRequestId,
        ),
    ];
  }
}
