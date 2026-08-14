import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/detect_regional_payment_method.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Suggests the regional default payment rail for the entered
/// currency, with a one-tap way to apply it (Issue #422, acceptance
/// criteria 1-2) — split out of [BankingGatewayFields] to stay under
/// the file line cap.
class BankingGatewayRegionalHint extends StatelessWidget {
  final String currency;
  final ValueNotifier<BankingGatewayProvider> provider;

  const BankingGatewayRegionalHint({super.key, required this.currency, required this.provider});

  @override
  Widget build(BuildContext context) {
    final suggested = DetectRegionalPaymentMethod.call(currency);
    return ValueListenableBuilder<BankingGatewayProvider>(
      valueListenable: provider,
      builder: (context, selected, _) {
        if (suggested == selected) return const SizedBox.shrink();
        return Row(children: [
          Text('Suggested for $currency: ${suggested.name}', style: const TextStyle(fontSize: 11)),
          ShadButton.ghost(onPressed: () => provider.value = suggested, child: const Text('Use')),
        ]);
      },
    );
  }
}
