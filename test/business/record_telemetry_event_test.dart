import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/record_telemetry_event.dart';
import 'package:growth_pilot_ai/core/enum/telemetry_event_type.dart';

void main() {
  test('builds an unuploaded event with the given fields', () {
    final now = DateTime.utc(2027, 6, 1);
    final event = RecordTelemetryEvent.call(
      eventType: TelemetryEventType.insightActioned,
      sectorId: 'tech',
      deltaChangeLabel: '+15% Liquidity',
      appVersion: '1.4.0',
      packVersion: 3,
      now: now,
    );

    expect(event.eventType, TelemetryEventType.insightActioned);
    expect(event.sectorId, 'tech');
    expect(event.deltaChangeLabel, '+15% Liquidity');
    expect(event.appVersion, '1.4.0');
    expect(event.packVersion, 3);
    expect(event.capturedAt, now);
    expect(event.uploaded, isFalse);
  });
}
