import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

/// Holds the new-transaction form's text controllers and provider
/// selection (Issue #421) — split out of
/// [BankingGatewayDialogContent] to stay under the file line cap.
class BankingGatewayFormController {
  final provider = ValueNotifier<BankingGatewayProvider>(BankingGatewayProvider.stripe);
  final counterpartyName = TextEditingController();
  final amount = TextEditingController();
  final currency = TextEditingController(text: 'CAD');

  bool get isValid =>
      counterpartyName.text.trim().isNotEmpty && double.tryParse(amount.text) != null;
}
