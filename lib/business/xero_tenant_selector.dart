import 'package:growth_pilot_ai/core/models/xero_tenant.dart';

/// Resolves which Xero organization to link. When exactly one is authorized it
/// can be auto-selected; otherwise the UI must prompt the user to choose.
class XeroTenantSelector {
  /// The single authorized tenant, or null when the user must choose (zero or
  /// more than one).
  static XeroTenant? autoOrNull(List<XeroTenant> tenants) =>
      tenants.length == 1 ? tenants.first : null;

  /// Looks up a chosen tenant by id, or null if it isn't in the authorized set.
  static XeroTenant? byId(List<XeroTenant> tenants, String tenantId) {
    for (final t in tenants) {
      if (t.tenantId == tenantId) return t;
    }
    return null;
  }
}
