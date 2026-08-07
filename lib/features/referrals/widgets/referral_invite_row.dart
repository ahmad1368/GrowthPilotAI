import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/classify_contact_identifier_type.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_invite_entity.dart';
import 'package:growth_pilot_ai/core/enum/contact_identifier_type.dart';
import 'package:growth_pilot_ai/core/enum/referral_channel.dart';
import 'package:growth_pilot_ai/core/enum/referral_invite_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One non-registered contact's referral invite row (Issue #542,
/// acceptance criteria 2-5).
class ReferralInviteRow extends StatelessWidget {
  final String contact;
  final ReferralInviteEntity invite;
  final void Function(ReferralChannel) onDispatch;
  final VoidCallback onRedeem;

  const ReferralInviteRow({
    super.key,
    required this.contact,
    required this.invite,
    required this.onDispatch,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    final type = ClassifyContactIdentifierType.call(contact);
    final daysLeft = invite.expiresAt.difference(DateTime.now()).inDays;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$contact — code ${invite.referralCode} — ${invite.status.name} — ${daysLeft}d left',
            style: const TextStyle(fontSize: 12)),
        Row(children: [
          if (type == ContactIdentifierType.phone)
            ShadButton.ghost(
                onPressed: () => onDispatch(ReferralChannel.smsApi), child: const Text('SMS')),
          if (type == ContactIdentifierType.email)
            ShadButton.ghost(
                onPressed: () => onDispatch(ReferralChannel.emailApi), child: const Text('Email')),
          ShadButton.ghost(
              onPressed: () => onDispatch(ReferralChannel.shareSheet), child: const Text('Share')),
          if (invite.status == ReferralInviteStatus.pending)
            ShadButton.ghost(onPressed: onRedeem, child: const Text('Simulate Redeem')),
        ]),
      ]),
    );
  }
}
