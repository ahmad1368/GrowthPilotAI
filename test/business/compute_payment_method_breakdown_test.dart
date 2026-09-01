import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_payment_fee_narrative.dart';
import 'package:growth_pilot_ai/business/compute_payment_method_breakdown.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

TransactionEntity _income(double amount, PaymentMethod method) {
  final t = TransactionEntity(
      amount: amount, description: 'sale', date: DateTime(2024, 1, 1), dbType: 1);
  t.paymentMethod = method;
  return t;
}

void main() {
  group('ComputePaymentMethodBreakdown', () {
    test('aggregates volume, share, and estimated fees per channel', () {
      final transactions = [
        _income(100, PaymentMethod.cash),
        _income(200, PaymentMethod.credit),
        _income(50, PaymentMethod.crypto),
      ];

      final result = ComputePaymentMethodBreakdown.call(transactions);

      expect(result.length, 3);
      final credit = result.firstWhere((b) => b.method == PaymentMethod.credit);
      expect(credit.totalAmount, 200);
      expect(credit.sharePercent, closeTo(200 / 350 * 100, 1e-9));
      expect(credit.estimatedProcessingFees, closeTo(200 * 0.029, 1e-9));

      final cash = result.firstWhere((b) => b.method == PaymentMethod.cash);
      expect(cash.estimatedProcessingFees, 0);
    });

    test('excludes expense transactions and empty channels', () {
      final transactions = [
        _income(100, PaymentMethod.cash),
        TransactionEntity(
            amount: 500, description: 'rent', date: DateTime(2024, 1, 2), dbType: 0)
          ..paymentMethod = PaymentMethod.credit,
      ];

      final result = ComputePaymentMethodBreakdown.call(transactions);

      expect(result.length, 1);
      expect(result.single.method, PaymentMethod.cash);
    });

    test('sorts by highest volume first', () {
      final transactions = [
        _income(50, PaymentMethod.crypto),
        _income(300, PaymentMethod.cash),
      ];

      final result = ComputePaymentMethodBreakdown.call(transactions);
      expect(result.first.method, PaymentMethod.cash);
    });
  });

  group('BuildPaymentFeeNarrative', () {
    test('falls back when there is no payment history', () {
      expect(BuildPaymentFeeNarrative.call(const []),
          contains('Not enough payment history'));
    });

    test('reports total fee drag and the top channel', () {
      final transactions = [_income(1000, PaymentMethod.credit)];
      final result = ComputePaymentMethodBreakdown.call(transactions);
      final narrative = BuildPaymentFeeNarrative.call(result);
      expect(narrative, contains('credit'));
    });
  });
}
