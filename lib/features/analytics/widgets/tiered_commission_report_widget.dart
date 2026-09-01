import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/tiered_commission_body.dart';

/// Registers the Tiered Commission Calculation and Transaction Revenue
/// Engine (Issue #425) as a pluggable report widget under id
/// `TIERED_COMMISSION_ENGINE` (#111) — no external data needed;
/// [TieredCommissionBody] reads existing wholesale orders (#411) and
/// dependency evaluations (#424) itself.
class TieredCommissionReportWidget extends BaseReportWidget {
  const TieredCommissionReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const TieredCommissionBody();
  }
}
