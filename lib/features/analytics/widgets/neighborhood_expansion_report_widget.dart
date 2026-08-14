import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/neighborhood_expansion_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/neighborhood_expansion_body.dart';

/// Registers the Adjacent Neighborhood Expansion Potential Analyzer
/// (Issue #372) as a pluggable report widget under id
/// `NEIGHBORHOOD_EXPANSION_ANALYZER` (#111).
class NeighborhoodExpansionReportWidget extends BaseReportWidget {
  const NeighborhoodExpansionReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return NeighborhoodExpansionBody(
      initialEvaluations:
          data['evaluations'] as List<NeighborhoodExpansionEntity>,
    );
  }
}
