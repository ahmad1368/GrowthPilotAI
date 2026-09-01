import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_fields.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_form_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful new-transaction form for [showBankingGatewayDialog]
/// (Issue #421).
class BankingGatewayDialogContent extends StatefulWidget {
  const BankingGatewayDialogContent({super.key});

  @override
  State<BankingGatewayDialogContent> createState() => _BankingGatewayDialogContentState();
}

class _BankingGatewayDialogContentState extends State<BankingGatewayDialogContent> {
  final _form = BankingGatewayFormController();

  void _submit() {
    if (!_form.isValid) return;
    Navigator.of(context).pop((
      provider: _form.provider.value,
      counterpartyName: _form.counterpartyName.text.trim(),
      amount: double.tryParse(_form.amount.text) ?? 0,
      currency: _form.currency.text.trim().isEmpty ? 'CAD' : _form.currency.text.trim(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('New Gateway Transaction'),
      description: SingleChildScrollView(child: BankingGatewayFields(form: _form)),
      actions: [
        ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(onPressed: _submit, child: const Text('Authorize')),
      ],
    );
  }
}
