import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/summarize_funnel_events.dart';
import 'package:growth_pilot_ai/core/data/entities/local_usage_event_entity.dart';
import 'package:growth_pilot_ai/core/enum/usage_event_type.dart';

LocalUsageEventEntity _event(String label) => LocalUsageEventEntity(
      dbType: UsageEventType.actionCompleted.index,
      label: label,
      occurredAt: DateTime(2026, 1, 1),
    );

void main() {
  group('SummarizeFunnelEvents', () {
    test('counts each step in the given order (Issue #194)', () {
      final events = [
        _event('sign_up_start'),
        _event('sign_up_start'),
        _event('sign_up_complete'),
        _event('invoice_scanned_success'),
      ];

      final funnel = SummarizeFunnelEvents.call(
          events, ['sign_up_start', 'sign_up_complete', 'invoice_scanned_success', 'premium_upgrade_initiated']);

      expect(funnel.map((s) => s.label).toList(),
          ['sign_up_start', 'sign_up_complete', 'invoice_scanned_success', 'premium_upgrade_initiated']);
      expect(funnel[0].count, 2);
      expect(funnel[1].count, 1);
      expect(funnel[2].count, 1);
      expect(funnel[3].count, 0);
    });

    test('ignores events whose label is not in the funnel', () {
      final events = [_event('unrelated_event')];
      final funnel = SummarizeFunnelEvents.call(events, ['sign_up_start']);
      expect(funnel.single.count, 0);
    });

    test('returns zeroed counts for an empty event list', () {
      final funnel = SummarizeFunnelEvents.call(const [], ['sign_up_start', 'sign_up_complete']);
      expect(funnel.every((s) => s.count == 0), isTrue);
    });
  });
}
