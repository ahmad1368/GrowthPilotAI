import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_multi_merchant_narrative.dart';
import 'package:growth_pilot_ai/business/compute_multi_merchant_overview.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';

MerchantBranchEntity _branch({
  String branchName = 'Downtown',
  required double salesTotal,
  BranchInventoryStatus status = BranchInventoryStatus.healthy,
  DateTime? reportedAt,
}) =>
    MerchantBranchEntity(
      branchName: branchName,
      salesTotal: salesTotal,
      dbInventoryStatus: status.index,
      reportedAt: reportedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeMultiMerchantOverview', () {
    test('returns empty list when no branches are logged', () {
      expect(ComputeMultiMerchantOverview.call(const []), isEmpty);
    });

    test('computes each branch share of total enterprise sales', () {
      final results = ComputeMultiMerchantOverview.call([
        _branch(branchName: 'A', salesTotal: 3000),
        _branch(branchName: 'B', salesTotal: 1000),
      ]);

      final a = results.firstWhere((r) => r.branchName == 'A');
      final b = results.firstWhere((r) => r.branchName == 'B');
      expect(a.salesSharePercent, closeTo(75.0, 1e-9));
      expect(b.salesSharePercent, closeTo(25.0, 1e-9));
    });

    test('avoids division by zero when total sales are zero', () {
      final result =
          ComputeMultiMerchantOverview.call([_branch(salesTotal: 0)]).single;
      expect(result.salesSharePercent, 0);
    });

    test('sorts branches by sales total descending', () {
      final results = ComputeMultiMerchantOverview.call([
        _branch(branchName: 'Small', salesTotal: 100),
        _branch(branchName: 'Big', salesTotal: 900),
      ]);

      expect(results.first.branchName, 'Big');
      expect(results.last.branchName, 'Small');
    });

    test('flags critical inventory status as needing attention', () {
      final result = ComputeMultiMerchantOverview.call(
          [_branch(status: BranchInventoryStatus.critical, salesTotal: 100)]).single;
      expect(result.needsAttention, isTrue);

      final healthy = ComputeMultiMerchantOverview.call(
          [_branch(status: BranchInventoryStatus.healthy, salesTotal: 100)]).single;
      expect(healthy.needsAttention, isFalse);
    });
  });

  group('BuildMultiMerchantNarrative', () {
    test('falls back when no branches are logged', () {
      expect(BuildMultiMerchantNarrative.call(const []),
          contains('No branches logged'));
    });

    test('names the top branch and flags critical branches', () {
      final results = ComputeMultiMerchantOverview.call([
        _branch(branchName: 'Top', salesTotal: 900),
        _branch(
            branchName: 'Struggling',
            salesTotal: 100,
            status: BranchInventoryStatus.critical),
      ]);

      final narrative = BuildMultiMerchantNarrative.call(results);
      expect(narrative, contains('Top'));
      expect(narrative, contains('Struggling'));
    });
  });
}
