import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_dialog_content.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// New gateway transaction wizard (Issue #421, acceptance criteria
/// 1-2). Returns the requested transaction's terms, or null if
/// cancelled/invalid.
typedef BankingGatewayRequest = ({
  BankingGatewayProvider provider,
  String counterpartyName,
  double amount,
  String currency,
});

Future<BankingGatewayRequest?> showBankingGatewayDialog(BuildContext context) {
  return showShadDialog<BankingGatewayRequest>(
    context: context,
    builder: (context) => const BankingGatewayDialogContent(),
  );
}
