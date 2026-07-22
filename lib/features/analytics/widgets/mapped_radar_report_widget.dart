import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/map_raw_data_to_chart_points.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/models/chart_axis_mapping.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/generic_radar_chart.dart';

/// Registers the generic mapped radar (Issue #112) as a pluggable report
/// widget under id `MAPPED_RADAR_CHART` (Issue #111's registry): the same
/// widget class renders any category's axes, driven entirely by `spec.data`.
class MappedRadarReportWidget extends BaseReportWidget {
  const MappedRadarReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final raw = data['raw'] as Map<String, dynamic>;
    final mapping = data['mapping'] as List<ChartAxisMapping>;
    return GenericRadarChart(
      points: MapRawDataToChartPoints.call(raw, mapping),
    );
  }
}
