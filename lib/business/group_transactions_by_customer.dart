import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/customer_revenue_group.dart';

/// Groups income transactions by normalized description text as a buyer
/// proxy (Issue #376) — see [CustomerRevenueGroup] for why. A group with
/// 2+ transactions counts as a repeat buyer.
class GroupTransactionsByCustomer {
  static List<CustomerRevenueGroup> call(List<TransactionEntity> transactions) {
    final revenueByKey = <String, double>{};
    final countByKey = <String, int>{};
    final labelByKey = <String, String>{};
    final firstByKey = <String, DateTime>{};
    final lastByKey = <String, DateTime>{};

    for (final t in transactions) {
      if (t.type != TransactionType.income) continue;
      final label = t.description.trim().isEmpty
          ? 'Unknown customer'
          : t.description.trim();
      final key = label.toLowerCase();
      revenueByKey[key] = (revenueByKey[key] ?? 0) + t.amount;
      countByKey[key] = (countByKey[key] ?? 0) + 1;
      labelByKey.putIfAbsent(key, () => label);
      firstByKey[key] =
          firstByKey.containsKey(key) && firstByKey[key]!.isBefore(t.date)
              ? firstByKey[key]!
              : t.date;
      lastByKey[key] = lastByKey.containsKey(key) && lastByKey[key]!.isAfter(t.date)
          ? lastByKey[key]!
          : t.date;
    }

    return [
      for (final key in revenueByKey.keys)
        CustomerRevenueGroup(
          label: labelByKey[key]!,
          totalRevenue: revenueByKey[key]!,
          transactionCount: countByKey[key]!,
          isRepeat: countByKey[key]! >= 2,
          firstPurchaseDate: firstByKey[key]!,
          lastPurchaseDate: lastByKey[key]!,
        ),
    ]..sort((a, b) => b.totalRevenue.compareTo(a.totalRevenue));
  }
}
