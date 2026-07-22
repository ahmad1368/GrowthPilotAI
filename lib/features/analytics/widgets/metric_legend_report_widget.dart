import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compass_metric_legend.dart';

/// Registers the Business Compass metric legend (Issue #84) as a pluggable
/// report widget under id `METRIC_LEGEND` (Issue #111).
class MetricLegendReportWidget extends BaseReportWidget {
  const MetricLegendReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return CompassMetricLegend(
      userMetrics: data['user'] as BusinessCompassMetrics,
    );
  }
}
