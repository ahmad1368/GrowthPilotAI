import 'package:growth_pilot_ai/core/models/widget_config_option.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_registry.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/insight_narrative_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/mapped_radar_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/metric_legend_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/radar_report_widget.dart';

/// One-time registration of the analytics report widgets into
/// [ReportWidgetRegistry] (Issue #111). Adding a new widget type elsewhere
/// only needs one more line like these.
class ReportWidgetsBootstrap {
  static void register() {
    ReportWidgetRegistry.register(
        'RADAR_CHART', (spec) => RadarReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'METRIC_LEGEND',
        (spec) =>
            MetricLegendReportWidget(data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'INSIGHT_TEXT',
        (spec) => InsightNarrativeReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'MAPPED_RADAR_CHART',
        (spec) => MappedRadarReportWidget(
            data: spec.data, title: spec.title));
    ReportWidgetRegistry.register(
        'PROFIT_MARGIN_CHART',
        (spec) => ProfitMarginReportWidget(
            data: spec.data, title: spec.title));
  }

  /// Registers each widget's config side-panel options (Issue #115).
  static void registerConfig() {
    WidgetConfigRegistry.register('RADAR_CHART', const [
      WidgetConfigOption(key: 'showBenchmark', label: 'Show sector benchmark'),
    ]);
  }
}
