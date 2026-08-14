import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/account_suspension_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One merchant's suspension status row (Issue #341). Tapping "Lift"
/// manually approves an early unsuspension (acceptance criterion 3).
class AccountSuspensionRow extends StatelessWidget {
  final AccountSuspensionStatus result;
  final VoidCallback onLift;

  const AccountSuspensionRow({super.key, required this.result, required this.onLift});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('${result.merchantName} — ${result.reason}',
                  overflow: TextOverflow.ellipsis)),
          Text(result.isActive ? 'Suspended' : 'Active',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: result.isActive ? scheme.primary : scheme.onSurface.withValues(alpha: 0.6))),
          if (result.isActive) ...[
            const SizedBox(width: 8),
            ShadButton.ghost(onPressed: onLift, child: const Text('Lift')),
          ],
        ],
      ),
    );
  }
}
