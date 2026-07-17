import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/seed_integration_connections.dart';
import 'package:growth_pilot_ai/core/data/entities/integration_connection_entity.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';

void main() {
  group('SeedIntegrationConnections.call', () {
    test('seeds all three providers as notConnected when none exist', () {
      final seeds = SeedIntegrationConnections.call([]);

      expect(seeds.map((s) => s.providerId),
          containsAll(['plaid', 'quickbooks', 'xero']));
      expect(seeds.every((s) => s.dbStatus == DashboardConnectionStatus.notConnected.index),
          isTrue);
    });

    test('skips providers that already have a row', () {
      final existing = [
        IntegrationConnectionEntity(
          providerId: 'plaid',
          providerLabel: 'Plaid',
          dbStatus: DashboardConnectionStatus.connected.index,
        ),
      ];

      final seeds = SeedIntegrationConnections.call(existing);

      expect(seeds.map((s) => s.providerId), isNot(contains('plaid')));
      expect(seeds.map((s) => s.providerId), containsAll(['quickbooks', 'xero']));
    });
  });
}
