import 'package:flutter/widgets.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';

/// Renders a list of [ReportWidgetSpec]s through [ReportWidgetRegistry]
/// (Issue #111), so a page only decides *what* to show, never *how*.
class DynamicReportGallery extends StatelessWidget {
  final List<ReportWidgetSpec> specs;

  const DynamicReportGallery({super.key, required this.specs});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final spec in specs) ...[
          ReportWidgetRegistry.build(spec),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
