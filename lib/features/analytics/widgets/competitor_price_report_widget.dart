import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_price_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_price_body.dart';

/// Registers the Real-Time Competitor Price Comparison Engine (Issue
/// #351) as a pluggable report widget under id
/// `COMPETITOR_PRICE_COMPARISON` (#111).
class CompetitorPriceReportWidget extends BaseReportWidget {
  const CompetitorPriceReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return CompetitorPriceBody(
      initialObservations:
          data['observations'] as List<CompetitorPriceObservationEntity>,
    );
  }
}
