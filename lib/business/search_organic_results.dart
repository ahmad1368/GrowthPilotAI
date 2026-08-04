import 'package:growth_pilot_ai/business/compute_search_relevance.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/models/search_result_item.dart';

/// Ranks organic (non-sponsored) merchant matches for the search query
/// (Issue #404, acceptance criterion 3), most relevant first.
class SearchOrganicResults {
  static List<SearchResultItem> call(List<MerchantConfigEntity> configs, String query) {
    final scored = configs
        .map((c) => (config: c, relevance: ComputeSearchRelevance.call(c.businessName, query)))
        .where((entry) => entry.relevance > 0)
        .toList()
      ..sort((a, b) => b.relevance.compareTo(a.relevance));

    return scored
        .map((entry) => SearchResultItem(
              name: entry.config.businessName,
              category: '',
              isSponsored: false,
            ))
        .toList();
  }
}
