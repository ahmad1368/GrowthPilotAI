import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One sub-account row on the Connected Accounts screen (Issue #68):
/// masked number, balance, sync toggle, and a "Fix Connection" button when
/// Plaid reports `ITEM_LOGIN_REQUIRED`. Never shows the full account number.
class AccountListItem extends StatelessWidget {
  final LinkedAccountEntity account;
  final bool isBusy;
  final ValueChanged<bool> onToggle;
  final VoidCallback onFixConnection;

  const AccountListItem({
    super.key,
    required this.account,
    required this.isBusy,
    required this.onToggle,
    required this.onFixConnection,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(account.accountType == 'credit'
          ? Icons.credit_card_rounded
          : Icons.account_balance_wallet_rounded),
      title: Text(account.officialName),
      subtitle: Text('**** ${account.mask}'),
      trailing: account.needsReauth
          ? ShadButton.destructive(
              enabled: !isBusy,
              onPressed: onFixConnection,
              child: Text(isBusy ? 'Fixing...' : 'Fix Connection'),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('\$${account.currentBalance.toStringAsFixed(2)}'),
                const SizedBox(width: 8),
                Switch(value: account.isActive, onChanged: onToggle),
              ],
            ),
    );
  }
}
