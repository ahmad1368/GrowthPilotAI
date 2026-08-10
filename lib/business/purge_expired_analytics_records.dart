import 'package:growth_pilot_ai/business/is_analytics_record_expired.dart';
import 'package:growth_pilot_ai/core/data/repositories/anonymized_listing_repository.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// "Scheduled Purge Job" (Issue #94 scope item 3) — this app has no cron,
/// so a caller (e.g. app-start or a manual admin action) invokes this
/// directly instead of `@Cron(EVERY_DAY_AT_MIDNIGHT)`. Logs only the
/// count removed, never the purged records themselves (AC: "without
/// logging the deleted data itself").
class PurgeExpiredAnalyticsRecords {
  static int call(AnonymizedListingRepository repo, DateTime now) {
    final expiredIds = repo
        .getAll()
        .where((r) => IsAnalyticsRecordExpired.call(r.expireAt, now))
        .map((r) => r.id)
        .toList();
    if (expiredIds.isEmpty) return 0;

    final removed = repo.removeMany(expiredIds);
    OmniLogger.info('Retention purge: $removed expired analytics record(s) removed.');
    return removed;
  }
}
