import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';

/// Renders a plain-text insight (Issue #111's `INSIGHT_TEXT` id) — the
/// third distinct widget type proving the registry isn't hardcoded to
/// charts and lists.
class InsightNarrativeReportWidget extends BaseReportWidget {
  const InsightNarrativeReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return Text(
      data['narrative'] as String,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
