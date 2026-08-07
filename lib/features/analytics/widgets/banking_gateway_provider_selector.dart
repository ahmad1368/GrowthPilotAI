import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Provider selector chips (Issue #421, acceptance criterion 1) —
/// split out of [BankingGatewayFields] to stay under the file line
/// cap.
class BankingGatewayProviderSelector extends StatelessWidget {
  final ValueNotifier<BankingGatewayProvider> selection;

  const BankingGatewayProviderSelector({super.key, required this.selection});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BankingGatewayProvider>(
      valueListenable: selection,
      builder: (context, selected, _) => Wrap(spacing: 4, children: [
        for (final p in BankingGatewayProvider.values)
          ShadButton.outline(
              onPressed: () => selection.value = p,
              child: Text(selected == p ? '● ${p.name}' : p.name)),
      ]),
    );
  }
}
