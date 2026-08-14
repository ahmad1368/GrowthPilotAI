import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_intelligence_body.dart';

/// Registers the Competitive Pricing Intelligence engine (Issue
/// #416) as a pluggable report widget under id
/// `PRICE_INTELLIGENCE_ENGINE` (#111).
class PriceIntelligenceReportWidget extends BaseReportWidget {
  const PriceIntelligenceReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return PriceIntelligenceBody(
        observations: data['observations'] as List<CompetitorPriceObservationEntity>);
  }
}
