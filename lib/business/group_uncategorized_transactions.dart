import 'package:growth_pilot_ai/business/transaction_mapper.dart';
import 'package:growth_pilot_ai/core/data/entities/mapping_rule_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/chart_of_account.dart';
import 'package:growth_pilot_ai/core/models/merchant_mapping_group.dart';

/// Groups uncategorized transactions by vendor/merchant and runs each group
/// through Issue #57's [TransactionMapper] to get a suggested account
/// (Issue #58 — Category Mapping screen data source).
class GroupUncategorizedTransactions {
  static List<MerchantMappingGroup> call({
    required List<TransactionEntity> transactions,
    required List<MappingRuleEntity> rules,
    required List<ChartOfAccount> chartOfAccounts,
  }) {
    final byMerchant = <String, List<TransactionEntity>>{};
    for (final t in transactions) {
      final merchant = t.vendor.target?.name ?? t.description;
      byMerchant.putIfAbsent(merchant, () => []).add(t);
    }

    return byMerchant.entries.map((entry) {
      final rawCategory = entry.value.first.category.target?.name ?? '';
      final mapping = TransactionMapper.map(
        merchantName: entry.key,
        rawCategory: rawCategory,
        rules: rules,
        chartOfAccounts: chartOfAccounts,
      );
      return MerchantMappingGroup(
        merchantName: entry.key,
        transactions: entry.value,
        mapping: mapping,
      );
    }).toList();
  }
}
