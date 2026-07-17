import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/institution_account_group.dart';
import 'package:growth_pilot_ai/features/settings/widgets/account_list_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One institution's expandable group of sub-accounts (Issue #68).
class InstitutionAccordionItem extends StatelessWidget {
  final InstitutionAccountGroup group;
  final String? busyAccountId;
  final void Function(String accountId, bool value) onToggle;
  final void Function(String accountId) onFixConnection;

  const InstitutionAccordionItem({
    super.key,
    required this.group,
    required this.busyAccountId,
    required this.onToggle,
    required this.onFixConnection,
  });

  @override
  Widget build(BuildContext context) {
    return ShadAccordionItem<String>(
      value: group.institutionName,
      title: Text(group.institutionName),
      child: Column(
        children: group.accounts
            .map((account) => AccountListItem(
                  account: account,
                  isBusy: busyAccountId == account.accountId,
                  onToggle: (v) => onToggle(account.accountId, v),
                  onFixConnection: () => onFixConnection(account.accountId),
                ))
            .toList(),
      ),
    );
  }
}
