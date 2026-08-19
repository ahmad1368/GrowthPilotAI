import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/core/enum/traceability_quick_filter.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_matrix_grid.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_quick_filter_chips.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_tree_view.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Smart Traceability Matrix & Cross-Platform Gap Analysis UI" (Issue
/// #239) — a sticky-header [TraceabilityMatrixGrid] on wide layouts
/// (Web/Tablet), a drill-down [TraceabilityTreeView] on narrow ones
/// (Mobile).
class TraceabilityMatrixScreen extends StatefulWidget {
  const TraceabilityMatrixScreen({super.key});

  @override
  State<TraceabilityMatrixScreen> createState() => _TraceabilityMatrixScreenState();
}

class _TraceabilityMatrixScreenState extends State<TraceabilityMatrixScreen> {
  TraceabilityQuickFilter? _filter;

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final controller = Get.find<TraceabilityController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Traceability Matrix'),
        backgroundColor: colors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            tooltip: 'Export to Excel',
            onPressed: controller.exportMatrixToXlsx,
          ),
          IconButton(
            icon: const Icon(Icons.description_outlined),
            tooltip: 'Export to CSV',
            onPressed: controller.exportMatrixToCsv,
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            tooltip: 'Preview Report',
            onPressed: () => Get.toNamed('/requirements/traceability/report-preview'),
          ),
          IconButton(
            icon: const Icon(Icons.ios_share_outlined),
            tooltip: 'Share All (XLSX + CSV)',
            onPressed: controller.shareAllExports,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TraceabilityQuickFilterChips(
                value: _filter,
                onChanged: (f) => setState(() => _filter = f),
              ),
              const SizedBox(height: 12),
              LayoutBuilder(builder: (context, constraints) {
                return constraints.maxWidth >= 800
                    ? TraceabilityMatrixGrid(controller: controller)
                    : TraceabilityTreeView(controller: controller, filter: _filter);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
