import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/confirm_mapping_usecase.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/mapping_result.dart';
import 'package:growth_pilot_ai/core/models/merchant_mapping_group.dart';

void main() {
  final mappingGroup = MerchantMappingGroup(
    merchantName: 'Amazon',
    transactions: [
      TransactionEntity(amount: 10, date: DateTime(2026), description: 'Amazon')..id = 1,
      TransactionEntity(amount: 20, date: DateTime(2026), description: 'Amazon')..id = 2,
    ],
    mapping: const MappingResult(
      suggestedAccountId: 'acc-office',
      confidence: 0.4,
      source: MappingSource.fuzzyMatch,
    ),
  );

  group('ConfirmMappingUseCase.call', () {
    test('creates one confirmed status per transaction in the group', () {
      final plan = ConfirmMappingUseCase.call(
        group: mappingGroup,
        selectedAccountId: 'acc-office',
        selectedAccountName: 'Office Supplies',
        createRule: false,
      );

      expect(plan.statuses.length, 2);
      expect(plan.statuses.map((s) => s.transactionId), containsAll([1, 2]));
      expect(plan.statuses.first.confirmedAccountId, 'acc-office');
      expect(plan.newRule, isNull);
    });

    test('creates a new auto-map rule when createRule is true', () {
      final plan = ConfirmMappingUseCase.call(
        group: mappingGroup,
        selectedAccountId: 'acc-office',
        selectedAccountName: 'Office Supplies',
        createRule: true,
      );

      expect(plan.newRule, isNotNull);
      expect(plan.newRule!.merchantPattern, 'Amazon');
      expect(plan.newRule!.targetAccountId, 'acc-office');
    });
  });
}
