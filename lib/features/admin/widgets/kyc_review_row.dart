import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/kyc_verification_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One pending submission in the admin "KYC Approval Queue" (Issue #151
/// scope item 2) — flat row, not the issue's literal Glassmorphism ask.
class KycReviewRow extends StatelessWidget {
  final KycVerificationEntity submission;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const KycReviewRow({
    super.key,
    required this.submission,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration:
          BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        Expanded(
            child: Text(submission.userId,
                style: TextStyle(color: colors.foreground, fontWeight: FontWeight.w600))),
        ShadButton.outline(onPressed: onReject, child: const Text('Reject')),
        const SizedBox(width: 8),
        ShadButton(onPressed: onApprove, child: const Text('Approve')),
      ]),
    );
  }
}
