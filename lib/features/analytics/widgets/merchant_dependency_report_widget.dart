import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_dependency_body.dart';

/// Registers the User Engagement and High-Dependency Behavioral
/// Detection Engine (Issue #424) as a pluggable report widget under
/// id `MERCHANT_DEPENDENCY_ENGINE` (#111) — no external data needed;
/// [MerchantDependencyBody] reads existing wholesale orders (#411)
/// and its own telemetry ledgers itself.
class MerchantDependencyReportWidget extends BaseReportWidget {
  const MerchantDependencyReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const MerchantDependencyBody();
  }
}
