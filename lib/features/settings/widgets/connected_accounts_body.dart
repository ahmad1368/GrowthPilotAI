import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/connected_accounts_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/combined_balance_header.dart';
import 'package:growth_pilot_ai/features/settings/widgets/institution_accordion_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Scrollable content of the Connected Accounts screen (Issue #68):
/// combined-balance header + grouped accordion, or an empty state.
class ConnectedAccountsBody extends StatelessWidget {
  final ConnectedAccountsController controller;

  const ConnectedAccountsBody({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CombinedBalanceHeader(combinedBalance: controller.combinedBalance),
        const SizedBox(height: 16),
        if (controller.groups.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: Text('No linked accounts.')),
          )
        else
          ShadAccordion<String>.multiple(
            children: controller.groups
                .map((group) => InstitutionAccordionItem(
                      group: group,
                      busyAccountId: controller.busyAccountId.value,
                      onToggle: controller.toggleActive,
                      onFixConnection: controller.fixConnection,
                    ))
                .toList(),
          ),
      ],
    );
  }
}
