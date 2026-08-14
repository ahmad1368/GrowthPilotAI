import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_exchange_conversion.dart';
import 'package:growth_pilot_ai/business/compute_gateway_fee.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

/// Live conversion/fee disclosure preview (Issue #421, acceptance
/// criterion 2) — split out of [BankingGatewayFields] to stay under
/// the file line cap.
class BankingGatewayFeePreview extends StatelessWidget {
  final ValueNotifier<BankingGatewayProvider> provider;
  final double amount;
  final String currency;

  const BankingGatewayFeePreview(
      {super.key, required this.provider, required this.amount, required this.currency});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BankingGatewayProvider>(
      valueListenable: provider,
      builder: (context, selected, _) {
        final conversion = ComputeExchangeConversion.call(amount, currency);
        final fee = ComputeGatewayFee.call(selected, conversion.convertedAmount);
        return Text(
            'CAD ${conversion.convertedAmount.toStringAsFixed(2)} '
            '(rate ${conversion.exchangeRate.toStringAsFixed(3)}) — fee CAD ${fee.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 12));
      },
    );
  }
}
