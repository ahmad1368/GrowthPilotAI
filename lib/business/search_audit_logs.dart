import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';

/// Filters the audit trail by admin identity and/or target merchant
/// (Issue #343, acceptance criterion 2) — blank queries match
/// everything, most recent entry first.
class SearchAuditLogs {
  static List<AuditLogEntity> call(
      List<AuditLogEntity> logs, String adminQuery, String merchantQuery) {
    final admin = adminQuery.trim().toLowerCase();
    final merchant = merchantQuery.trim().toLowerCase();

    final results = logs.where((l) {
      final matchesAdmin = admin.isEmpty || l.adminId.toLowerCase().contains(admin);
      final matchesMerchant =
          merchant.isEmpty || l.targetMerchant.toLowerCase().contains(merchant);
      return matchesAdmin && matchesMerchant;
    }).toList();

    results.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return results;
  }
}
