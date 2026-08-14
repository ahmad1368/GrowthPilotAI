import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_invite_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/unmatched_contact_entity.dart';
import 'package:growth_pilot_ai/core/enum/referral_channel.dart';
import 'package:growth_pilot_ai/features/referrals/widgets/referral_actions.dart';
import 'package:growth_pilot_ai/features/referrals/widgets/referral_repos.dart';
import 'package:growth_pilot_ai/features/referrals/widgets/referral_view.dart';

/// Owns referral state for the non-registered contacts #541's sync
/// found (Issue #542) — one demo "inviting user" identity, since this
/// app has no real authenticated multi-user session.
class ReferralBody extends StatefulWidget {
  const ReferralBody({super.key});
  @override
  State<ReferralBody> createState() => _ReferralBodyState();
}

class _ReferralBodyState extends State<ReferralBody> {
  static const _inviterName = 'You';
  final _repos = ReferralRepos();
  late final _actions = ReferralActions(_repos);
  late final List<UnmatchedContactEntity> _contacts = _repos.unmatchedContacts.getAll();

  ReferralInviteEntity _inviteFor(String contact) =>
      _actions.getOrCreateInvite(_inviterName, contact);

  Future<void> _dispatch(String contact, ReferralChannel channel) async {
    await _actions.dispatch(_inviteFor(contact), channel);
    setState(() {});
  }

  void _redeem(String contact) {
    _actions.redeem(_inviteFor(contact));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ReferralView(
      contacts: _contacts,
      inviteFor: _inviteFor,
      onDispatch: _dispatch,
      onRedeem: _redeem,
    );
  }
}
