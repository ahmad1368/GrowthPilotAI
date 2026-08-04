import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/search_results_body.dart';

/// Registers Sponsored Search Results (Issue #404) as a pluggable
/// report widget under id `SPONSORED_SEARCH_DASHBOARD` (#111).
class SearchResultsReportWidget extends BaseReportWidget {
  const SearchResultsReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return SearchResultsBody(
      merchantConfigs: data['configs'] as List<MerchantConfigEntity>,
      approvedRequests: data['adRequests'] as List<AdvertisingRequestEntity>,
    );
  }
}
