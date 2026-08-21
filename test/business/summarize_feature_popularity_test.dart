import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/summarize_feature_popularity.dart';
import 'package:growth_pilot_ai/core/data/entities/local_usage_event_entity.dart';
import 'package:growth_pilot_ai/core/enum/usage_event_type.dart';

LocalUsageEventEntity _event(String label) => LocalUsageEventEntity(
      dbType: UsageEventType.actionCompleted.index,
      label: label,
      occurredAt: DateTime(2026, 1, 1),
    );

void main() {
  group('SummarizeFeaturePopularity', () {
    test('sorts distinct labels most-used first (Issue #194)', () {
      final events = [
        _event('invoice_scanned_success'),
        _event('marketplace_match_viewed'),
        _event('invoice_scanned_success'),
        _event('invoice_scanned_success'),
      ];

      final popularity = SummarizeFeaturePopularity.call(events);

      expect(popularity.first.label, 'invoice_scanned_success');
      expect(popularity.first.count, 3);
      expect(popularity.last.label, 'marketplace_match_viewed');
      expect(popularity.last.count, 1);
    });

    test('returns an empty list for no events', () {
      expect(SummarizeFeaturePopularity.call(const []), isEmpty);
    });
  });
}
