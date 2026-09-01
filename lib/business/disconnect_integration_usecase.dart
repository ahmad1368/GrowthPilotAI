import 'package:growth_pilot_ai/core/data/entities/integration_connection_entity.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';
import 'package:growth_pilot_ai/core/models/disconnect_integration_plan.dart';

const _accountingProviderIds = {'quickbooks', 'xero'};

/// Pure decision logic for disconnecting a provider (Issue #61): resets its
/// status to [notConnected] and flags whether auto-map rules must be
/// cleared (only accounting providers own Chart-of-Accounts rules; Plaid
/// bank links do not).
class DisconnectIntegrationUseCase {
  static DisconnectIntegrationPlan call(IntegrationConnectionEntity entity) {
    final updated = IntegrationConnectionEntity(
      id: entity.id,
      providerId: entity.providerId,
      providerLabel: entity.providerLabel,
      dbStatus: DashboardConnectionStatus.notConnected.index,
    );
    return DisconnectIntegrationPlan(
      updatedEntity: updated,
      clearsMappingRules: _accountingProviderIds.contains(entity.providerId),
    );
  }
}
