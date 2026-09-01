import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/token_refresh_outcome.dart';
import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';
import 'package:growth_pilot_ai/core/enum/integration_status.dart';
import 'package:growth_pilot_ai/core/models/accounting_integration.dart';

void main() {
  const integration = AccountingIntegration(
    provider: AccountingProvider.xero,
    status: IntegrationStatus.disconnected,
  );

  group('TokenRefreshOutcome.onSuccess', () {
    test('marks the integration connected', () {
      final result = TokenRefreshOutcome.onSuccess(integration);
      expect(result.status, IntegrationStatus.connected);
      expect(result.provider, integration.provider);
    });
  });

  group('TokenRefreshOutcome.onFailure', () {
    test('marks the integration disconnected, triggering reconnect UX', () {
      const connected = AccountingIntegration(
        provider: AccountingProvider.quickbooks,
        status: IntegrationStatus.connected,
      );
      final result =
          TokenRefreshOutcome.onFailure(connected, reason: 'invalid_grant');
      expect(result.status, IntegrationStatus.disconnected);
      expect(result.status.needsReconnect, isTrue);
    });
  });
}
