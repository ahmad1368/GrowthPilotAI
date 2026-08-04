import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/account_suspension_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders why a merchant's transactional access is blocked (Issue
/// #341, acceptance criterion 2) — feature screens gated by merchant
/// suspension should show this in place of their content whenever
/// [IsAccountSuspended] returns true, mirroring [ServiceLockNotice].
class AccountSuspensionNotice extends StatelessWidget {
  final AccountSuspensionStatus status;

  const AccountSuspensionNotice({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return ShadCard(
      child: Row(
        children: [
          Icon(Icons.block, color: fg, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text('${status.merchantName} is suspended until '
                '${status.expiresAt} ("${status.reason}").'),
          ),
        ],
      ),
    );
  }
}
