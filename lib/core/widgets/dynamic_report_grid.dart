import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/grid_layout_service.dart';
import 'package:growth_pilot_ai/core/widgets/report_widget_registry.dart';
import 'package:growth_pilot_ai/utils/responsive_helper.dart';

/// Masonry layout for [ReportWidgetSpec]s (Issue #113): full-width widgets
/// (radar charts) stack above pairs of half-width ones, with no fixed row
/// height so each tile sizes to its own content.
class DynamicReportGrid extends StatelessWidget {
  final List<ReportWidgetSpec> specs;

  const DynamicReportGrid({super.key, required this.specs});

  @override
  Widget build(BuildContext context) {
    final totalColumns = ResponsiveHelper.isMobile(context) ? 2 : 4;
    return StaggeredGrid.count(
      crossAxisCount: totalColumns,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        for (final spec in specs)
          StaggeredGridTile.fit(
            crossAxisCellCount:
                GridLayoutService.getCrossAxisCellCount(spec.id, totalColumns),
            child: RepaintBoundary(child: ReportWidgetRegistry.build(spec)),
          ),
      ],
    );
  }
}
