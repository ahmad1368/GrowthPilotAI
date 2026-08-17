import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/summarize_usage_events.dart';
import 'package:growth_pilot_ai/core/data/entities/local_usage_event_entity.dart';
import 'package:growth_pilot_ai/core/enum/usage_event_type.dart';

void main() {
  group('SummarizeUsageEvents', () {
    test('counts events per type, including zero for unseen types', () {
      final events = [
        LocalUsageEventEntity(
            dbType: UsageEventType.screenView.index, label: 'Dashboard', occurredAt: DateTime(2026)),
        LocalUsageEventEntity(
            dbType: UsageEventType.screenView.index, label: 'Settings', occurredAt: DateTime(2026)),
        LocalUsageEventEntity(
            dbType: UsageEventType.appOpen.index, label: '', occurredAt: DateTime(2026)),
      ];

      final summary = SummarizeUsageEvents.call(events);

      expect(summary[UsageEventType.screenView], 2);
      expect(summary[UsageEventType.appOpen], 1);
      expect(summary[UsageEventType.searchPerformed], 0);
    });

    test('empty log summarizes to all zeros', () {
      final summary = SummarizeUsageEvents.call([]);

      expect(summary.values.every((v) => v == 0), isTrue);
    });
  });
}
