import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/core/models/compliance_risk_item.dart';

/// Ranks compliance items by urgency, soonest-expiring first (Issue #392).
/// [warningWindowDays] is a documented default "risk window" — this app
/// has no municipal registry to pull real regulatory deadlines from.
class ComputeComplianceRisk {
  static const warningWindowDays = 30;

  static List<ComplianceRiskItem> call(List<ComplianceItemEntity> items, DateTime now) {
    final results = items.map((item) {
      final days = item.expiryDate.difference(now).inDays;
      final level = days < 0
          ? ComplianceRiskLevel.expired
          : (days <= warningWindowDays
              ? ComplianceRiskLevel.expiringSoon
              : ComplianceRiskLevel.ok);
      return ComplianceRiskItem(
        name: item.name,
        expiryDate: item.expiryDate,
        daysUntilExpiry: days,
        riskLevel: level,
      );
    }).toList()
      ..sort((a, b) => a.daysUntilExpiry.compareTo(b.daysUntilExpiry));

    return results;
  }
}
