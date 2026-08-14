import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_account_suspension_narrative.dart';
import 'package:growth_pilot_ai/core/models/account_suspension_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/account_suspension_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-merchant suspension rows, a suspend button, and a
/// summary narrative (Issue #341). Purely presentational — the
/// suspension list is owned by [AccountSuspensionBody].
class AccountSuspensionView extends StatelessWidget {
  final List<AccountSuspensionStatus> results;
  final VoidCallback onSuspend;
  final ValueChanged<AccountSuspensionStatus> onLift;

  const AccountSuspensionView({
    super.key,
    required this.results,
    required this.onSuspend,
    required this.onLift,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onSuspend,
              child: Text('+ Suspend', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results)
          AccountSuspensionRow(result: result, onLift: () => onLift(result)),
        const SizedBox(height: 8),
        Text(BuildAccountSuspensionNarrative.call(results)),
      ],
    );
  }
}
