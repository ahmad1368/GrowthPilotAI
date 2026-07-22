import 'package:growth_pilot_ai/core/models/widget_config_option.dart';

/// Maps a report widget id to the config options it exposes in the
/// side-panel (Issue #115), mirroring [ReportWidgetRegistry]'s pattern.
class WidgetConfigRegistry {
  static final Map<String, List<WidgetConfigOption>> _options = {};

  static void register(String widgetId, List<WidgetConfigOption> options) {
    _options[widgetId] = options;
  }

  /// Widgets with no registered options simply have nothing to configure.
  static List<WidgetConfigOption> optionsFor(String widgetId) =>
      _options[widgetId] ?? const [];
}
