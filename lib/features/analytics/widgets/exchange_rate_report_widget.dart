import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/exchange_rate_observation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/exchange_rate_body.dart';

/// Registers the Exchange Rate Impact Analysis Engine (Issue #371) as a
/// pluggable report widget under id `EXCHANGE_RATE_IMPACT` (#111).
class ExchangeRateReportWidget extends BaseReportWidget {
  const ExchangeRateReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return ExchangeRateBody(
      initialObservations:
          data['observations'] as List<ExchangeRateObservationEntity>,
    );
  }
}
