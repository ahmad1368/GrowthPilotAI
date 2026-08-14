import 'package:growth_pilot_ai/core/models/search_result_item.dart';

/// Composes the unified search result list with sponsored slots
/// positioned first (Issue #404, acceptance criterion 1) — both inputs
/// are already relevance-filtered/sorted by [SearchSponsoredResults]
/// and [SearchOrganicResults].
class BuildSearchResults {
  static List<SearchResultItem> call(
      List<SearchResultItem> sponsored, List<SearchResultItem> organic) {
    return [...sponsored, ...organic];
  }
}
