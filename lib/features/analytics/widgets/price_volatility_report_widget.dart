import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/price_volatility_body.dart';

/// Registers the Automated Price Fluctuation & Grocery Risk Alert System
/// (Issue #340) as a pluggable report widget under id
/// `PRICE_VOLATILITY_ALERT` (#111).
class PriceVolatilityReportWidget extends BaseReportWidget {
  const PriceVolatilityReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return PriceVolatilityBody(
      observations: data['observations'] as List<CompetitorPriceObservationEntity>,
      initialThresholdPercent: data['thresholdPercent'] as double,
    );
  }
}
