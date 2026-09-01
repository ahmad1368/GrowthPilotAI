import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_body.dart';

/// Registers the Local and International Banking Gateways
/// Integration simulation (Issue #421) as a pluggable report widget
/// under id `BANKING_GATEWAY_ORCHESTRATION` (#111) — no external data
/// needed; [BankingGatewayBody] owns its own transaction store.
class BankingGatewayReportWidget extends BaseReportWidget {
  const BankingGatewayReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const BankingGatewayBody();
  }
}
