import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/analytics_pricing_tier_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/analytics_pricing_body.dart';

/// Registers Dynamic Monetization & Advanced Analytics Pricing (Issue
/// #336) as a pluggable report widget under id `ANALYTICS_PRICING_TIERS`
/// (#111).
class AnalyticsPricingReportWidget extends BaseReportWidget {
  const AnalyticsPricingReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return AnalyticsPricingBody(
      initialTiers: data['tiers'] as List<AnalyticsPricingTierEntity>,
    );
  }
}
