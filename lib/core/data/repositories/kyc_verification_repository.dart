import '../../../../objectbox.g.dart';
import '../../enum/kyc_verification_status.dart';
import '../entities/kyc_verification_entity.dart';

/// Thin ObjectBox wrapper for KYC submissions (Issue #144) — one row
/// per user, upserted in place.
class KycVerificationRepository {
  final Box<KycVerificationEntity> _box;

  KycVerificationRepository(this._box);

  KycVerificationEntity? getForUser(String userId) {
    final query = _box.query(KycVerificationEntity_.userId.equals(userId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  /// The moderator queue (Issue #151 scope item 2): submissions awaiting
  /// a human decision.
  List<KycVerificationEntity> getPending() {
    final query = _box
        .query(KycVerificationEntity_.dbStatus.equals(KycVerificationStatus.pending.index))
        .build();
    final result = query.find();
    query.close();
    return result;
  }

  int upsert(KycVerificationEntity submission) => _box.put(submission);
}
