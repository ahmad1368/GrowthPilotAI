import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/welcome_back_summary.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Welcome Back" banner (Issue #214's "In-App Highlights") — shown when
/// a dormant user ([IsUserDormant]) returns, summarizing real local
/// activity captured while they were away. Flat design, not the issue's
/// wider social/email re-engagement machinery (see PR notes).
class WelcomeBackBanner extends StatelessWidget {
  final WelcomeBackSummary summary;
  final VoidCallback onDismiss;

  const WelcomeBackBanner({super.key, required this.summary, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    if (!summary.hasAnyUpdates) return const SizedBox.shrink();
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Welcome back! You were away ${summary.daysAway} days — "
              "${summary.newTransactionsCount} new transactions and "
              "${summary.newInsightsCount} new insights.",
              style: TextStyle(color: colors.foreground, fontSize: 13),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: colors.mutedForeground, size: 16),
            onPressed: onDismiss,
          ),
        ],
      ),
    );
  }
}
