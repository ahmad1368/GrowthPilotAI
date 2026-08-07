import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/settlement_tracking_body.dart';

/// Registers the Real-Time Settlement Tracking and Financial Logistics
/// Dashboard (Issue #426) as a pluggable report widget under id
/// `SETTLEMENT_TRACKING_DASHBOARD` (#111) — no external data needed;
/// [SettlementTrackingBody] reads existing gateway transactions
/// (#421-423) and escrow accounts (#415) itself.
class SettlementTrackingReportWidget extends BaseReportWidget {
  const SettlementTrackingReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const SettlementTrackingBody();
  }
}
