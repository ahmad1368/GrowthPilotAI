import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_invite_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/unmatched_contact_entity.dart';
import 'package:growth_pilot_ai/core/enum/referral_channel.dart';
import 'package:growth_pilot_ai/features/referrals/widgets/referral_invite_row.dart';

/// Renders one referral row per non-registered contact (Issue #542).
/// Purely presentational.
class ReferralView extends StatelessWidget {
  final List<UnmatchedContactEntity> contacts;
  final ReferralInviteEntity Function(String) inviteFor;
  final void Function(String, ReferralChannel) onDispatch;
  final void Function(String) onRedeem;

  const ReferralView({
    super.key,
    required this.contacts,
    required this.inviteFor,
    required this.onDispatch,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    if (contacts.isEmpty) {
      return const Text(
        'No non-registered contacts yet — sync contacts above to find people to invite.',
        style: TextStyle(fontSize: 12),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final contact in contacts)
        ReferralInviteRow(
          contact: contact.rawIdentifier,
          invite: inviteFor(contact.rawIdentifier),
          onDispatch: (channel) => onDispatch(contact.rawIdentifier, channel),
          onRedeem: () => onRedeem(contact.rawIdentifier),
        ),
    ]);
  }
}
