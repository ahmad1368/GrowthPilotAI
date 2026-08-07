import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/contact_sync_result.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_consent_banner.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_input_field.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_preference_toggle.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_result_list.dart';

/// Renders the consent notice, sync controls, and results (Issue
/// #541). Purely presentational.
class ContactSyncView extends StatelessWidget {
  final bool isEnabled;
  final ContactSyncResult? result;
  final void Function(bool) onSetEnabled;
  final void Function(String) onSync;

  const ContactSyncView({
    super.key,
    required this.isEnabled,
    required this.result,
    required this.onSetEnabled,
    required this.onSync,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ContactSyncPreferenceToggle(isEnabled: isEnabled, onChanged: onSetEnabled),
      if (isEnabled) ...[
        const SizedBox(height: 8),
        const ContactSyncConsentBanner(),
        const SizedBox(height: 8),
        ContactSyncInputField(onSync: onSync),
        const SizedBox(height: 8),
        if (result != null) ContactSyncResultList(result: result!),
      ],
    ]);
  }
}
