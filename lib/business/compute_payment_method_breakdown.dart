import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/payment_method_breakdown.dart';

/// Per-channel customer payment volume and estimated processing-fee drag
/// (Issue #391), over income transactions only (customer-facing revenue
/// events). Fee rates are well-known industry-standard approximations,
/// not merchant-negotiated real rates, since this app tracks no actual
/// processing-fee data.
class ComputePaymentMethodBreakdown {
  static const _feeRates = {
    PaymentMethod.unspecified: 0.0,
    PaymentMethod.cash: 0.0,
    PaymentMethod.credit: 0.029,
    PaymentMethod.crypto: 0.01,
  };

  static List<PaymentMethodBreakdown> call(List<TransactionEntity> transactions) {
    final income =
        transactions.where((t) => t.type == TransactionType.income).toList();
    final totalAmount = income.fold<double>(0, (sum, t) => sum + t.amount);

    return PaymentMethod.values
        .map((method) {
          final matched = income.where((t) => t.paymentMethod == method);
          final amount = matched.fold<double>(0, (sum, t) => sum + t.amount);
          return PaymentMethodBreakdown(
            method: method,
            transactionCount: matched.length,
            totalAmount: amount,
            sharePercent: totalAmount <= 0 ? 0 : amount / totalAmount * 100,
            estimatedProcessingFees: amount * _feeRates[method]!,
          );
        })
        .where((b) => b.transactionCount > 0)
        .toList()
      ..sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
  }
}
