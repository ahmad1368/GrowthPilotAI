import 'package:growth_pilot_ai/business/generate_deterministic_hash.dart';
import 'package:growth_pilot_ai/core/data/repositories/anonymized_listing_repository.dart';
import 'package:growth_pilot_ai/core/models/hash_pepper.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// "Right to be Forgotten" for the analytics store (Issue #94 AC) — the
/// SQL/production half of this AC has no single equivalent store in this
/// app (raw data is spread across many entities: KYC docs, memberships,
/// sessions, ...), so a full cross-cutting user purge is left for a
/// dedicated future issue; this covers the shadow-record half.
class PurgeUserAnalyticsData {
  static int call(AnonymizedListingRepository repo, String rawUserId, HashPepper pepper) {
    final hashedId = GenerateDeterministicHash.call(rawUserId, pepper);
    final matchIds = repo.getByHashedId(hashedId).map((r) => r.id).toList();
    if (matchIds.isEmpty) return 0;

    final removed = repo.removeMany(matchIds);
    OmniLogger.info('Right to be forgotten: $removed analytics record(s) removed.');
    return removed;
  }
}
