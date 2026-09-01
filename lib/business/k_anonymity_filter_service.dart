import 'package:growth_pilot_ai/business/apply_k_anonymity.dart';
import 'package:growth_pilot_ai/core/models/anonymous_record.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Applies [ApplyKAnonymity] to outgoing [AnonymousRecord]s (Issue #90),
/// grouping by region+period — the two generalized quasi-identifiers
/// #80's pipeline already produces — and audit-logging how many records
/// were suppressed for having too small a group.
class KAnonymityFilterService {
  List<AnonymousRecord> filter(List<AnonymousRecord> records, {int k = 5}) {
    final result = ApplyKAnonymity.call<AnonymousRecord>(
      records,
      (r) => '${r.region}-${r.period}',
      k: k,
    );
    OmniLogger.info('K-anonymity: ${result.suppressedCount} record(s) suppressed (k=$k)');
    return result.data;
  }
}
