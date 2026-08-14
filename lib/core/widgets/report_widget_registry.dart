import 'package:flutter/widgets.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';

/// Maps a [ReportWidgetSpec.id] to the widget that renders it (Issue #111).
/// Adding a new report widget only requires one extra map entry here.
class ReportWidgetRegistry {
  static final Map<String, Widget Function(ReportWidgetSpec spec)> _builders =
      {};

  /// Registers (or overrides) the builder for [id].
  static void register(
      String id, Widget Function(ReportWidgetSpec spec) builder) {
    _builders[id] = builder;
  }

  /// Builds the widget for [spec.id], or an empty box if the id is
  /// unknown — unknown ids must never crash the app.
  static Widget build(ReportWidgetSpec spec) {
    final builder = _builders[spec.id];
    return builder != null ? builder(spec) : const SizedBox.shrink();
  }
}
