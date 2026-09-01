import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/rewarded_unlock_entity.dart';

/// One read-only rewarded unlock log entry (Issue #405, acceptance
/// criterion 5) — the completion token is truncated for display but
/// kept in full on the record for advertiser verification.
class RewardedUnlockRow extends StatelessWidget {
  final RewardedUnlockEntity unlock;
  final bool isActive;

  const RewardedUnlockRow({super.key, required this.unlock, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text('${unlock.merchantName} — ${unlock.moduleName}',
                  overflow: TextOverflow.ellipsis)),
          Text('token ${unlock.completionToken.substring(0, 6)}…',
              style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 8),
          Text(isActive ? 'Active' : 'Expired',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isActive ? scheme.primary : scheme.onSurface.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}
