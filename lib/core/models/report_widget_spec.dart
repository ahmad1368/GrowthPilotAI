import 'package:flutter/foundation.dart';

/// One entry in a "report bundle" (Issue #111): a widget [id] the
/// [ReportWidgetRegistry] knows how to build, plus the [data] it needs.
/// Stands in for the JSON payload a backend would send in the issue's
/// original design — built locally here since no backend exists.
@immutable
class ReportWidgetSpec {
  final String id;
  final String title;
  final Map<String, dynamic> data;

  const ReportWidgetSpec({
    required this.id,
    required this.title,
    required this.data,
  });
}
