import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_broadcast_narrative.dart';
import 'package:growth_pilot_ai/business/compute_broadcast_read_rates.dart';
import 'package:growth_pilot_ai/core/data/entities/emergency_broadcast_entity.dart';

EmergencyBroadcastEntity _broadcast({
  String messageBody = 'Evacuate the area',
  String targetNeighborhoods = 'downtown',
  int recipientCount = 10,
  int readCount = 0,
  DateTime? dispatchedAt,
}) =>
    EmergencyBroadcastEntity(
      messageBody: messageBody,
      targetNeighborhoods: targetNeighborhoods,
      recipientCount: recipientCount,
      readCount: readCount,
      dispatchedAt: dispatchedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeBroadcastReadRates', () {
    test('returns empty list when no broadcasts are logged', () {
      expect(ComputeBroadcastReadRates.call(const []), isEmpty);
    });

    test('computes read rate from reported counts', () {
      final result = ComputeBroadcastReadRates.call(
          [_broadcast(recipientCount: 10, readCount: 4)]).single;

      expect(result.readRatePercent, closeTo(40.0, 1e-9));
    });

    test('avoids division by zero when no recipients were reported', () {
      final result = ComputeBroadcastReadRates.call(
          [_broadcast(recipientCount: 0, readCount: 0)]).single;

      expect(result.readRatePercent, 0);
    });

    test('sorts broadcasts by most recently dispatched first', () {
      final results = ComputeBroadcastReadRates.call([
        _broadcast(messageBody: 'Old', dispatchedAt: DateTime(2024, 1, 1)),
        _broadcast(messageBody: 'New', dispatchedAt: DateTime(2024, 6, 1)),
      ]);

      expect(results.first.messageBody, 'New');
      expect(results.last.messageBody, 'Old');
    });
  });

  group('BuildBroadcastNarrative', () {
    test('falls back when no broadcasts are logged', () {
      expect(BuildBroadcastNarrative.call(const []),
          contains('No emergency broadcasts dispatched'));
    });

    test('names the most recent broadcast and its read counts', () {
      final results = ComputeBroadcastReadRates.call([
        _broadcast(targetNeighborhoods: 'Kitsilano', recipientCount: 20, readCount: 5),
      ]);

      final narrative = BuildBroadcastNarrative.call(results);
      expect(narrative, contains('Kitsilano'));
      expect(narrative, contains('5/20'));
    });
  });
}
