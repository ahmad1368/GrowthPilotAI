import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/supplier_scorecard.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';

/// Ranks vendors by average spend per transaction, lowest first (Issue
/// #369) — the closest local proxy for "price competitiveness" this app's
/// data model supports. The lowest-average-price vendor is flagged as
/// recommended for the next order.
class ComputeSupplierScorecards {
  static List<SupplierScorecard> call(List<TransactionEntity> transactions) {
    final byVendor = <String, List<TransactionEntity>>{};
    for (final t in transactions.where((t) => t.type == TransactionType.expense)) {
      final name = t.vendor.target?.name;
      if (name == null) continue;
      (byVendor[name] ??= []).add(t);
    }

    final results = byVendor.entries.map((e) {
      final txs = e.value..sort((a, b) => a.date.compareTo(b.date));
      final amounts = txs.map((t) => t.amount).toList();
      final total = amounts.fold(0.0, (sum, a) => sum + a);
      return SupplierScorecard(
        vendorName: e.key,
        totalSpend: total,
        transactionCount: txs.length,
        averageAmount: total / txs.length,
        priceTrend: ForecastEngine.detectTrend(amounts),
      );
    }).toList()
      ..sort((a, b) => a.averageAmount.compareTo(b.averageAmount));

    if (results.isEmpty) return results;
    final top = results.first;
    return [
      SupplierScorecard(
        vendorName: top.vendorName,
        totalSpend: top.totalSpend,
        transactionCount: top.transactionCount,
        averageAmount: top.averageAmount,
        priceTrend: top.priceTrend,
        isRecommended: true,
      ),
      ...results.skip(1),
    ];
  }
}
