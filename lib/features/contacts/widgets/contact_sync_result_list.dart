import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:growth_pilot_ai/business/build_quick_invite_message.dart';
import 'package:growth_pilot_ai/core/models/contact_sync_result.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Matched-friends and unmatched-contact readout, with a Quick Chat
/// Invitation share action per unmatched contact (Issue #541,
/// value-added feature 1).
class ContactSyncResultList extends StatelessWidget {
  final ContactSyncResult result;
  const ContactSyncResultList({super.key, required this.result});

  void _invite() {
    SharePlus.instance.share(ShareParams(text: BuildQuickInviteMessage.call('GrowthPilot AI')));
  }

  @override
  Widget build(BuildContext context) {
    if (result.matchedNames.isEmpty && result.unmatchedIdentifiers.isEmpty) {
      return const Text('No matches — try pasting one of the demo directory entries.',
          style: TextStyle(fontSize: 12));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final name in result.matchedNames)
        Text('✓ $name is already on GrowthPilot AI', style: const TextStyle(fontSize: 12)),
      for (final contact in result.unmatchedIdentifiers)
        Row(children: [
          Expanded(child: Text('$contact — not on the app yet', style: const TextStyle(fontSize: 12))),
          ShadButton.ghost(onPressed: _invite, child: const Text('Invite')),
        ]),
    ]);
  }
}
