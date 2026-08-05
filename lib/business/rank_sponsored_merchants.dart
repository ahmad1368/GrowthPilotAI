import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';

/// Ranks approved advertising requests (#401) for the sponsored
/// leaderboard slots (Issue #408, acceptance criterion 2) — this app
/// has no real bidding market, so the most recently approved sponsor
/// wins ties, the same recency-as-bidding-weight approximation
/// [SearchSponsoredResults] (#404) uses.
class RankSponsoredMerchants {
  static List<LeaderboardEntry> call(List<AdvertisingRequestEntity> requests) {
    final approved = requests.where((r) => r.status == AdRequestStatus.approved).toList()
      ..sort((a, b) => b.requestedAt.compareTo(a.requestedAt));

    return approved
        .map((r) => LeaderboardEntry(
              rank: 0,
              name: r.merchantName,
              score: double.infinity,
              isSponsored: true,
              sourceRequestId: r.id,
            ))
        .toList();
  }
}
