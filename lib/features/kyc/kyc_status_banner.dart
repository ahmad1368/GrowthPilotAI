import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Success/Rejection" status banner (Issue #144 UI Clarity AC) — flat,
/// not the issue's literal Glassmorphism ask.
class KycStatusBanner extends StatelessWidget {
  final KycVerificationStatus status;
  final String? rejectionReason;

  const KycStatusBanner({super.key, required this.status, this.rejectionReason});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final (label, detail) = switch (status) {
      KycVerificationStatus.none => ('Not started', 'Submit your documents to get verified.'),
      KycVerificationStatus.pending => ('Pending review', 'Your documents are being reviewed.'),
      KycVerificationStatus.verified => ('Verified', 'Your identity has been confirmed.'),
      KycVerificationStatus.rejected =>
        ('Rejected', rejectionReason ?? 'Please resubmit your documents.'),
    };
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(detail, style: TextStyle(fontSize: 12, color: colors.mutedForeground)),
      ]),
    );
  }
}
