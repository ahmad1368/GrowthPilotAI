import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_compliance_risk.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/core/models/compliance_risk_item.dart';

void main() {
  final now = DateTime(2026, 6, 15);

  test('flags an item expired in the past', () {
    final item = ComplianceItemEntity(name: 'Health Permit', expiryDate: DateTime(2026, 6, 1));
    final results = ComputeComplianceRisk.call([item], now);

    expect(results.single.riskLevel, ComplianceRiskLevel.expired);
    expect(results.single.daysUntilExpiry, -14);
  });

  test('flags an item expiring within the warning window as expiringSoon', () {
    final item = ComplianceItemEntity(name: 'Business License', expiryDate: DateTime(2026, 6, 30));
    final results = ComputeComplianceRisk.call([item], now);

    expect(results.single.riskLevel, ComplianceRiskLevel.expiringSoon);
  });

  test('flags a far-future item as ok', () {
    final item = ComplianceItemEntity(name: 'Zoning Certificate', expiryDate: DateTime(2027, 1, 1));
    final results = ComputeComplianceRisk.call([item], now);

    expect(results.single.riskLevel, ComplianceRiskLevel.ok);
  });

  test('sorts by soonest-expiring first', () {
    final items = [
      ComplianceItemEntity(name: 'Far', expiryDate: DateTime(2027, 1, 1)),
      ComplianceItemEntity(name: 'Overdue', expiryDate: DateTime(2026, 5, 1)),
      ComplianceItemEntity(name: 'Soon', expiryDate: DateTime(2026, 6, 20)),
    ];

    final results = ComputeComplianceRisk.call(items, now);

    expect(results.map((r) => r.name), ['Overdue', 'Soon', 'Far']);
  });

  test('no items returns an empty list', () {
    expect(ComputeComplianceRisk.call([], now), isEmpty);
  });
}
