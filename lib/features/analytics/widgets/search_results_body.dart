import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_search_results.dart';
import 'package:growth_pilot_ai/business/record_promo_click.dart';
import 'package:growth_pilot_ai/business/record_promo_impression.dart';
import 'package:growth_pilot_ai/business/search_organic_results.dart';
import 'package:growth_pilot_ai/business/search_sponsored_results.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/promo_card_metrics_repository.dart';
import 'package:growth_pilot_ai/core/models/search_result_item.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/search_results_view.dart';

/// Owns the query and attributes sponsored-slot impressions/clicks
/// (Issue #404, acceptance criterion 5) via the same telemetry entity
/// the native feed card (#402) and contextual banner (#403) write to —
/// a promotion surfaced through search is still the same underlying
/// advertising request, just another placement.
class SearchResultsBody extends StatefulWidget {
  final List<MerchantConfigEntity> merchantConfigs;
  final List<AdvertisingRequestEntity> approvedRequests;

  const SearchResultsBody(
      {super.key, required this.merchantConfigs, required this.approvedRequests});

  @override
  State<SearchResultsBody> createState() => _SearchResultsBodyState();
}

class _SearchResultsBodyState extends State<SearchResultsBody> {
  String _query = '';
  final _impressedRequestIds = <int>{};

  void _recordImpressionsForNewSponsoredResults(List<SearchResultItem> results) {
    final repo = PromoCardMetricsRepository(
        Get.find<ObjectBox>().store.box<PromoCardMetricsEntity>());
    for (final result in results) {
      final id = result.advertisingRequestId;
      if (!result.isSponsored || id == null || _impressedRequestIds.contains(id)) continue;
      _impressedRequestIds.add(id);
      repo.save(RecordPromoImpression.call(repo.forRequest(id), id, DateTime.now()));
    }
  }

  void _onResultTap(SearchResultItem result) {
    final id = result.advertisingRequestId;
    if (!result.isSponsored || id == null) return;
    final repo = PromoCardMetricsRepository(
        Get.find<ObjectBox>().store.box<PromoCardMetricsEntity>());
    final existing = repo.forRequest(id);
    if (existing != null) repo.save(RecordPromoClick.call(existing));
  }

  @override
  Widget build(BuildContext context) {
    final sponsored = SearchSponsoredResults.call(widget.approvedRequests, _query);
    final organic = SearchOrganicResults.call(widget.merchantConfigs, _query);
    final results = BuildSearchResults.call(sponsored, organic);
    if (_query.isNotEmpty) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _recordImpressionsForNewSponsoredResults(results));
    }
    return SearchResultsView(
      results: results,
      onQueryChanged: (q) => setState(() => _query = q),
      onResultTap: _onResultTap,
    );
  }
}
