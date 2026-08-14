import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/b2b_analytics_body.dart';

/// "B2B Intelligence Hub" dashboard widget (Issue #129).
class B2bAnalyticsReportWidget extends BaseReportWidget {
  const B2bAnalyticsReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) => const B2bAnalyticsBody();
}
