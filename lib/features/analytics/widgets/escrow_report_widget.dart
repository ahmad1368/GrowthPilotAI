import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_body.dart';

/// Registers the Smart Escrow and Refund Guarantee engine (Issue
/// #415) as a pluggable report widget under id
/// `SMART_ESCROW_ENGINE` (#111).
class EscrowReportWidget extends BaseReportWidget {
  const EscrowReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return EscrowBody(accounts: data['accounts'] as List<EscrowAccountEntity>);
  }
}
