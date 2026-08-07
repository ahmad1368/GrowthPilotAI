import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_fee_preview.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_form_controller.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_provider_selector.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_regional_hint.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Provider selection, counterparty/amount/currency fields, and a
/// live fee/conversion preview (Issue #421, acceptance criterion 2).
class BankingGatewayFields extends StatefulWidget {
  final BankingGatewayFormController form;

  const BankingGatewayFields({super.key, required this.form});

  @override
  State<BankingGatewayFields> createState() => _BankingGatewayFieldsState();
}

class _BankingGatewayFieldsState extends State<BankingGatewayFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BankingGatewayProviderSelector(selection: widget.form.provider),
        BankingGatewayRegionalHint(
            currency: widget.form.currency.text.trim(), provider: widget.form.provider),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Counterparty name/account'),
            controller: widget.form.counterpartyName),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: ShadInput(
                placeholder: const Text('Amount'),
                controller: widget.form.amount,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {})),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 80,
            child: ShadInput(
                placeholder: const Text('CAD'),
                controller: widget.form.currency,
                onChanged: (_) => setState(() {})),
          ),
        ]),
        const SizedBox(height: 4),
        BankingGatewayFeePreview(
          provider: widget.form.provider,
          amount: double.tryParse(widget.form.amount.text) ?? 0,
          currency: widget.form.currency.text.trim(),
        ),
      ],
    );
  }
}
