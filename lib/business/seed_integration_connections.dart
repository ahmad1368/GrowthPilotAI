import 'package:growth_pilot_ai/core/data/entities/integration_connection_entity.dart';
import 'package:growth_pilot_ai/core/enum/dashboard_connection_status.dart';

/// Default providers shown on the Integrations Dashboard (Issue #61), in
/// display order.
const _defaultProviders = [
  ('plaid', 'Plaid'),
  ('quickbooks', 'QuickBooks'),
  ('xero', 'Xero'),
];

/// Returns a [notConnected] row for every default provider missing from
/// [existing], so the dashboard always lists all three even before the
/// user connects anything.
class SeedIntegrationConnections {
  static List<IntegrationConnectionEntity> call(
      List<IntegrationConnectionEntity> existing) {
    final knownIds = existing.map((e) => e.providerId).toSet();
    return _defaultProviders
        .where((p) => !knownIds.contains(p.$1))
        .map((p) => IntegrationConnectionEntity(
              providerId: p.$1,
              providerLabel: p.$2,
              dbStatus: DashboardConnectionStatus.notConnected.index,
            ))
        .toList();
  }
}
