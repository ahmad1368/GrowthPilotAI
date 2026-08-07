import '../../../../objectbox.g.dart';
import '../entities/referral_reward_entity.dart';

/// Append-only access to granted referral rewards (Issue #542,
/// acceptance criterion 4).
class ReferralRewardRepository {
  final Box<ReferralRewardEntity> _box;

  ReferralRewardRepository(this._box);

  int record(ReferralRewardEntity reward) => _box.put(reward);

  List<ReferralRewardEntity> getAll() => _box.getAll();

  List<ReferralRewardEntity> forInvite(int referralInviteId) =>
      getAll().where((r) => r.referralInviteId == referralInviteId).toList();
}
