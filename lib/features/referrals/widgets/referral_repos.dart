import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_invite_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_reward_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/unmatched_contact_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/referral_invite_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/referral_reward_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/unmatched_contact_repository.dart';

/// Bundles the repositories the referral engine needs (Issue #542) —
/// reuses [UnmatchedContactRepository] (#541) as the non-registered
/// contact source.
class ReferralRepos {
  final store = Get.find<ObjectBox>().store;

  late final unmatchedContacts = UnmatchedContactRepository(store.box<UnmatchedContactEntity>());
  late final invites = ReferralInviteRepository(store.box<ReferralInviteEntity>());
  late final rewards = ReferralRewardRepository(store.box<ReferralRewardEntity>());
}
