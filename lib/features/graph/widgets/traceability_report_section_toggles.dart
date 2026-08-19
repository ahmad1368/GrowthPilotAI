import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/core/enum/traceability_report_section.dart';

/// "Page Toggling: a checkbox list to include/exclude specific pages"
/// (Issue #259).
class TraceabilityReportSectionToggles extends StatelessWidget {
  final TraceabilityController controller;

  const TraceabilityReportSectionToggles({super.key, required this.controller});

  static const _labels = {
    TraceabilityReportSection.summary: 'Executive Summary',
    TraceabilityReportSection.matrix: 'Traceability Matrix',
    TraceabilityReportSection.requirements: 'Requirements List',
  };

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Wrap(
        children: [
          for (final section in TraceabilityReportSection.values)
            CheckboxListTile(
              dense: true,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(_labels[section]!),
              value: controller.enabledReportSections.contains(section),
              onChanged: (_) => controller.toggleReportSection(section),
            ),
        ],
      );
    });
  }
}
