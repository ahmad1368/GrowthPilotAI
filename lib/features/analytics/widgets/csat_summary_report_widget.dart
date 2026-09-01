import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/csat_summary_body.dart';

/// Registers the Transaction-Based CSAT Score Analyzer (Issue #375) as a
/// pluggable report widget under id `CSAT_SCORE_ANALYZER` (#111).
class CsatSummaryReportWidget extends BaseReportWidget {
  const CsatSummaryReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return CsatSummaryBody(
      initialRatings: data['ratings'] as List<CsatRatingEntity>,
    );
  }
}
