import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_daily_visit_frequency.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_activity_event_entity.dart';

MerchantActivityEventEntity _event(String merchant, DateTime occurredAt) {
  return MerchantActivityEventEntity(merchantName: merchant, occurredAt: occurredAt);
}

void main() {
  final now = DateTime(2026, 6, 1);

  test('averages recent events over the tracking window', () {
    final events = List.generate(
      30,
      (i) => _event('Alpha', now.subtract(Duration(days: i))),
    );
    expect(ComputeDailyVisitFrequency.call('Alpha', events, now), 1.0);
  });

  test('ignores events outside the window and other merchants', () {
    final events = [
      _event('Alpha', now.subtract(const Duration(days: 60))),
      _event('Beta', now.subtract(const Duration(days: 1))),
    ];
    expect(ComputeDailyVisitFrequency.call('Alpha', events, now), 0.0);
  });
}
