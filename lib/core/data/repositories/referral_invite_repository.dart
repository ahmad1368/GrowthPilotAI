import '../../../../objectbox.g.dart';
import '../entities/referral_invite_entity.dart';

/// Insert/lookup CRUD for referral invites (Issue #542).
class ReferralInviteRepository {
  final Box<ReferralInviteEntity> _box;

  ReferralInviteRepository(this._box);

  int save(ReferralInviteEntity invite) => _box.put(invite);

  List<ReferralInviteEntity> getAll() => _box.getAll();

  ReferralInviteEntity? forContact(String contactIdentifier) =>
      getAll().where((i) => i.contactIdentifier == contactIdentifier).firstOrNull;
}
