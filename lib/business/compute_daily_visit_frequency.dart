import 'package:growth_pilot_ai/core/data/entities/merchant_activity_event_entity.dart';

/// Average logged logins/dashboard visits per day over the recent
/// tracking window (Issue #424, acceptance criterion 1) — the "daily
/// login and dashboard visit frequency" dependency signal.
class ComputeDailyVisitFrequency {
  static const windowDays = 30;

  static double call(
    String merchantName,
    List<MerchantActivityEventEntity> events,
    DateTime now,
  ) {
    final cutoff = now.subtract(const Duration(days: windowDays));
    final count = events
        .where((e) => e.merchantName == merchantName && !e.occurredAt.isBefore(cutoff))
        .length;
    return count / windowDays;
  }
}
