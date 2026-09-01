import 'package:flutter/foundation.dart';

/// The user's current legal-acceptance status (Issue #215) — [acceptedVersion]
/// is null before the first-run "Legal Acceptance" step is completed.
@immutable
class LegalConsentState {
  final String? acceptedVersion;
  final DateTime? acceptedAt;
  final bool dataUsageConsent;

  const LegalConsentState({
    this.acceptedVersion,
    this.acceptedAt,
    required this.dataUsageConsent,
  });
}
