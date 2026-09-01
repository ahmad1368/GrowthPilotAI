import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/aggregate_service_health_snapshot.dart';
import 'package:growth_pilot_ai/core/enum/service_health_status.dart';
import 'package:growth_pilot_ai/core/models/service_health_indicator.dart';

ServiceHealthIndicator _indicator(ServiceHealthStatus status) =>
    ServiceHealthIndicator(name: 'test', status: status, message: '');

void main() {
  group('AggregateServiceHealthSnapshot', () {
    test('returns up when every indicator is up (Issue #166)', () {
      final result = AggregateServiceHealthSnapshot.call([
        _indicator(ServiceHealthStatus.up),
        _indicator(ServiceHealthStatus.up),
      ]);
      expect(result, ServiceHealthStatus.up);
    });

    test('returns down when any indicator is down, even amid degraded ones', () {
      final result = AggregateServiceHealthSnapshot.call([
        _indicator(ServiceHealthStatus.up),
        _indicator(ServiceHealthStatus.degraded),
        _indicator(ServiceHealthStatus.down),
      ]);
      expect(result, ServiceHealthStatus.down);
    });

    test('returns degraded when no indicator is down but one is degraded', () {
      final result = AggregateServiceHealthSnapshot.call([
        _indicator(ServiceHealthStatus.up),
        _indicator(ServiceHealthStatus.degraded),
      ]);
      expect(result, ServiceHealthStatus.degraded);
    });

    test('returns up for an empty indicator list', () {
      expect(AggregateServiceHealthSnapshot.call(const []), ServiceHealthStatus.up);
    });
  });
}
