import 'package:growth_pilot_ai/core/models/dashboard_template.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';

/// Static "Template Store" library of Dashboard Template archetypes (Issue
/// #118) for the Business Compass — hardcoded for this release, per the
/// issue's own note. Fetching "Remote Templates" from a NestJS backend is a
/// documented follow-up (no backend exists in this repo).
class DashboardTemplateRegistry {
  static const List<DashboardTemplate> all = [
    DashboardTemplate(
      id: 'bargain_hunter',
      name: 'The Bargain Hunter',
      description: "Leads with your Success DNA vs. the sector benchmark.",
      layout: [
        WidgetLayout(widgetId: 'RADAR_CHART', position: 0),
        WidgetLayout(widgetId: 'MAPPED_RADAR_CHART', position: 1),
        WidgetLayout(widgetId: 'INSIGHT_TEXT', position: 2),
        WidgetLayout(widgetId: 'METRIC_LEGEND', position: 3),
      ],
    ),
    DashboardTemplate(
      id: 'neighborhood_expert',
      name: 'The Neighborhood Expert',
      description: 'Leads with axis-level detail and mapped market data.',
      layout: [
        WidgetLayout(widgetId: 'METRIC_LEGEND', position: 0),
        WidgetLayout(widgetId: 'MAPPED_RADAR_CHART', position: 1),
        WidgetLayout(widgetId: 'RADAR_CHART', position: 2),
        WidgetLayout(widgetId: 'INSIGHT_TEXT', position: 3),
      ],
    ),
    DashboardTemplate(
      id: 'trend_watcher',
      name: 'The Trend Watcher',
      description: 'Leads with the AI strategy narrative.',
      layout: [
        WidgetLayout(widgetId: 'INSIGHT_TEXT', position: 0),
        WidgetLayout(widgetId: 'RADAR_CHART', position: 1),
        WidgetLayout(widgetId: 'MAPPED_RADAR_CHART', position: 2),
        WidgetLayout(widgetId: 'METRIC_LEGEND', position: 3),
      ],
    ),
  ];
}
