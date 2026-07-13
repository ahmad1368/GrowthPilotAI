import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';

/// A completed accounting connection (client-visible result). Access/refresh
/// tokens live server-side only; the client keeps just the provider + realmId.
@immutable
class AccountingIntegration {
  final AccountingProvider provider;
  final String? realmId;

  const AccountingIntegration({required this.provider, this.realmId});
}
