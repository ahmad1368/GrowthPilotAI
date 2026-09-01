import 'package:objectbox/objectbox.dart';

/// Persisted connection state for one provider (Plaid/QuickBooks/Xero) on
/// the Integrations Dashboard (Issue #61). [dbStatus] mirrors
/// [DashboardConnectionStatus] as an int since ObjectBox enums are indexed
/// by declaration order and this must stay stable across app updates.
@Entity()
class IntegrationConnectionEntity {
  @Id()
  int id = 0;

  @Unique()
  String providerId; // 'plaid' | 'quickbooks' | 'xero'

  String providerLabel;
  int dbStatus; // DashboardConnectionStatus.index
  String? accountLabel; // institution/company name once connected
  DateTime? lastSyncedAt;

  IntegrationConnectionEntity({
    this.id = 0,
    required this.providerId,
    required this.providerLabel,
    required this.dbStatus,
    this.accountLabel,
    this.lastSyncedAt,
  });
}
