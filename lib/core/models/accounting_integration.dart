import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';
import 'package:growth_pilot_ai/core/enum/integration_status.dart';

/// A completed accounting connection (client-visible result). Access/refresh
/// tokens live server-side only; the client keeps just the provider + realmId
/// plus a [status] reflecting the last known token-refresh outcome.
@immutable
class AccountingIntegration {
  final AccountingProvider provider;
  final String? realmId;
  final IntegrationStatus status;

  const AccountingIntegration({
    required this.provider,
    this.realmId,
    this.status = IntegrationStatus.connected,
  });

  AccountingIntegration copyWith({IntegrationStatus? status}) =>
      AccountingIntegration(
        provider: provider,
        realmId: realmId,
        status: status ?? this.status,
      );
}
