import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/integration_connection_entity.dart';

/// What to persist when the user confirms disconnecting a provider
/// (Issue #61). Disconnecting an accounting provider (QuickBooks/Xero)
/// also invalidates its auto-map rules, since those rules point at that
/// provider's Chart of Accounts.
@immutable
class DisconnectIntegrationPlan {
  final IntegrationConnectionEntity updatedEntity;
  final bool clearsMappingRules;

  const DisconnectIntegrationPlan({
    required this.updatedEntity,
    required this.clearsMappingRules,
  });
}
