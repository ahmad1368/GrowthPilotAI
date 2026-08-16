import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/match_confidence.dart';
import 'package:growth_pilot_ai/core/models/response_verification.dart';

/// Small trust indicator next to an assistant message (Issue #203 AC:
/// warning icon when unverified, checkmark when "100% matched"). Shows
/// nothing when the message mentioned no currency figures to verify.
class VerificationBadge extends StatelessWidget {
  final ResponseVerification? verification;
  const VerificationBadge({super.key, required this.verification});

  @override
  Widget build(BuildContext context) {
    final v = verification;
    if (v == null || v.extractedAmounts.isEmpty) return const SizedBox.shrink();

    if (v.overallConfidence == MatchConfidence.exact) {
      return const Tooltip(
        message: 'Verified against your local records',
        child: Icon(Icons.verified_rounded, size: 14, color: Colors.green),
      );
    }
    return const Tooltip(
      message: 'Some numbers may be approximated. Please verify with your raw records.',
      child: Icon(Icons.warning_amber_rounded, size: 14, color: Colors.orange),
    );
  }
}
