import 'package:growth_pilot_ai/business/compute_search_relevance.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/core/models/search_result_item.dart';

/// Ranks approved advertising requests matching the search query (Issue
/// #404, acceptance criteria 1 and 3) — this app has no real bidding
/// market, so "bidding weight" is approximated by recency (the most
/// recently approved sponsor wins ties), ranked above organic results
/// by [SearchOrganicResults]'s caller. Only relevant matches are
/// returned; an unrelated query never surfaces a sponsored slot.
class SearchSponsoredResults {
  static List<SearchResultItem> call(
      List<AdvertisingRequestEntity> requests, String query) {
    final scored = requests
        .where((r) => r.status == AdRequestStatus.approved)
        .map((r) => (
              request: r,
              relevance: [
                ComputeSearchRelevance.call(r.category, query),
                ComputeSearchRelevance.call(r.merchantName, query),
              ].reduce((a, b) => a > b ? a : b),
            ))
        .where((entry) => entry.relevance > 0)
        .toList()
      ..sort((a, b) {
        final byRelevance = b.relevance.compareTo(a.relevance);
        return byRelevance != 0
            ? byRelevance
            : b.request.requestedAt.compareTo(a.request.requestedAt);
      });

    return scored
        .map((entry) => SearchResultItem(
              name: entry.request.merchantName,
              category: entry.request.category,
              isSponsored: true,
              advertisingRequestId: entry.request.id,
            ))
        .toList();
  }
}
