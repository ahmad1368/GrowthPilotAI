import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_impact_narrative.dart';
import 'package:growth_pilot_ai/business/compute_adjustment_impacts.dart';
import 'package:growth_pilot_ai/business/group_impacts_by_month.dart';
import 'package:growth_pilot_ai/business/parse_commission_rate.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';

AuditLogEntity _log({
  String changeType = 'updated commission structure',
  String targetMerchant = 'Acme Foods',
  String previousValue = '5.0% / \$10000.0',
  String newValue = '3.0% / \$10000.0',
  DateTime? timestamp,
}) =>
    AuditLogEntity(
      adminId: 'Ahmad_Salem_Pour',
      changeType: changeType,
      targetMerchant: targetMerchant,
      previousValue: previousValue,
      newValue: newValue,
      timestamp: timestamp ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ParseCommissionRate', () {
    test('extracts the leading percentage', () {
      expect(ParseCommissionRate.call('5.0% / \$10000.0'), 5.0);
    });

    test('returns null for a fixed-amount description', () {
      expect(ParseCommissionRate.call('\$3.0 flat / \$10000.0'), isNull);
    });
  });

  group('ComputeAdjustmentImpacts', () {
    test('ignores audit entries that are not commission structure changes', () {
      expect(ComputeAdjustmentImpacts.call([_log(changeType: 'created profile')]), isEmpty);
    });

    test('ignores fixed-amount before/after (no comparable rate)', () {
      expect(
          ComputeAdjustmentImpacts.call(
              [_log(previousValue: '\$3.0 flat / \$10000.0', newValue: '\$2.0 flat / \$10000.0')]),
          isEmpty);
    });

    test('computes the estimated profitability impact of a rate decrease', () {
      final result = ComputeAdjustmentImpacts.call(
          [_log(previousValue: '10.0% / \$10000.0', newValue: '5.0% / \$10000.0')]).single;

      expect(result.impactPercent, closeTo(50.0, 1e-9));
    });

    test('a rate increase produces a negative impact', () {
      final result = ComputeAdjustmentImpacts.call(
          [_log(previousValue: '5.0% / \$10000.0', newValue: '10.0% / \$10000.0')]).single;

      expect(result.impactPercent, lessThan(0));
    });

    test('sorts by most recent first', () {
      final results = ComputeAdjustmentImpacts.call([
        _log(targetMerchant: 'Old', timestamp: DateTime(2024, 1, 1)),
        _log(targetMerchant: 'New', timestamp: DateTime(2024, 6, 1)),
      ]);

      expect(results.first.merchantName, 'New');
    });
  });

  group('GroupImpactsByMonth', () {
    test('averages impacts within the same month', () {
      final impacts = ComputeAdjustmentImpacts.call([
        _log(timestamp: DateTime(2024, 3, 5), previousValue: '10.0% / \$1', newValue: '5.0% / \$1'),
        _log(timestamp: DateTime(2024, 3, 20), previousValue: '10.0% / \$1', newValue: '9.0% / \$1'),
      ]);

      final points = GroupImpactsByMonth.call(impacts);
      expect(points, hasLength(1));
      expect(points.single.changeCount, 2);
    });
  });

  group('BuildImpactNarrative', () {
    test('falls back when no adjustments are logged', () {
      expect(BuildImpactNarrative.call(const []), contains('No commission adjustments'));
    });

    test('names the merchant and rate change', () {
      final results = ComputeAdjustmentImpacts.call(
          [_log(targetMerchant: 'Acme Foods', previousValue: '10.0% / \$1', newValue: '5.0% / \$1')]);

      final narrative = BuildImpactNarrative.call(results);
      expect(narrative, contains('Acme Foods'));
      expect(narrative, contains('grew'));
    });
  });
}
