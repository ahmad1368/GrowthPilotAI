import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One tappable chip per [EscrowClaimReason] for filing a buyer's
/// refund claim (Issue #415, acceptance criteria 3-4) — split out of
/// [EscrowRowActions] to stay under the file line cap.
class EscrowClaimInput extends StatelessWidget {
  final void Function(EscrowClaimReason reason) onFileClaim;

  const EscrowClaimInput({super.key, required this.onFileClaim});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 4, children: [
      for (final reason in EscrowClaimReason.values)
        ShadButton.ghost(
            onPressed: () => onFileClaim(reason), child: Text('Claim: ${reason.name}')),
    ]);
  }
}
