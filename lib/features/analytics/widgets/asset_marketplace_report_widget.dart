import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/asset_body.dart';

/// Registers the Rapid Liquidation Marketplace for store equipment and
/// assets (Issue #412) as a pluggable report widget under id
/// `ASSET_LIQUIDATION_MARKETPLACE` (#111).
class AssetMarketplaceReportWidget extends BaseReportWidget {
  const AssetMarketplaceReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return AssetBody(listings: data['listings'] as List<AssetListingEntity>);
  }
}
