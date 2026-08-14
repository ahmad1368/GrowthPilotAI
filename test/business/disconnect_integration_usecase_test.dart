import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/disconnect_integration_usecase.dart';
import 'package:growth_pilot_ai/core/data/entities/integration_connection_entity.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';

void main() {
  group('DisconnectIntegrationUseCase.call', () {
    test('resets an accounting provider to notConnected and clears rules', () {
      final entity = IntegrationConnectionEntity(
        id: 7,
        providerId: 'quickbooks',
        providerLabel: 'QuickBooks',
        dbStatus: DashboardConnectionStatus.connected.index,
        accountLabel: 'mock-realm-123',
      );

      final plan = DisconnectIntegrationUseCase.call(entity);

      expect(plan.updatedEntity.id, 7);
      expect(plan.updatedEntity.dbStatus, DashboardConnectionStatus.notConnected.index);
      expect(plan.clearsMappingRules, isTrue);
    });

    test('disconnecting Plaid does not clear mapping rules', () {
      final entity = IntegrationConnectionEntity(
        providerId: 'plaid',
        providerLabel: 'Plaid',
        dbStatus: DashboardConnectionStatus.connected.index,
      );

      final plan = DisconnectIntegrationUseCase.call(entity);

      expect(plan.clearsMappingRules, isFalse);
    });
  });
}
