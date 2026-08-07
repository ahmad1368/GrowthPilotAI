import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_contact_sync_consent_notice.dart';

/// Explicit consent/explanation notice shown above the sync input
/// (Issue #541, acceptance criterion 1).
class ContactSyncConsentBanner extends StatelessWidget {
  const ContactSyncConsentBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      BuildContactSyncConsentNotice.call(),
      style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6)),
    );
  }
}
