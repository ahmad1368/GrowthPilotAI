import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/barter_body.dart';

/// Registers the Peer-to-Peer Barter and Goods Exchange Engine
/// (Issue #413) as a pluggable report widget under id
/// `BARTER_EXCHANGE_MARKETPLACE` (#111).
class BarterMarketplaceReportWidget extends BaseReportWidget {
  const BarterMarketplaceReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return BarterBody(listings: data['listings'] as List<BarterListingEntity>);
  }
}
