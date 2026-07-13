import 'package:growth_pilot_ai/core/models/anonymous_record.dart';
import 'package:growth_pilot_ai/core/utils/data_generalizer.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import 'package:growth_pilot_ai/core/utils/pseudonymizer.dart';

/// Client-side anonymization pipeline: strips identity before a record is
/// synced to analytics/cloud storage. Direct identifiers (names, emails, memo)
/// are dropped entirely; indirect ones are hashed or generalized. One-way.
class AnonymizerService {
  AnonymousRecord transformForStorage({
    required String orgId,
    required DateTime date,
    required double amount,
    String? postalCode,
    String? category,
  }) {
    final record = AnonymousRecord(
      orgHash: Pseudonymizer.hash(orgId),
      period: DataGeneralizer.monthPeriod(date),
      region: DataGeneralizer.forwardSortationArea(postalCode),
      amount: amount,
      category: category,
    );
    // Audit that anonymization happened — never the original values.
    OmniLogger.info('Record anonymized for analytics storage');
    return record;
  }
}
