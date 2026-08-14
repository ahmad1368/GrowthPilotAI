import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

/// Volume and estimated processing-fee drag for one payment channel
/// (Issue #391).
class PaymentMethodBreakdown {
  final PaymentMethod method;
  final int transactionCount;
  final double totalAmount;
  final double sharePercent;
  final double estimatedProcessingFees;

  const PaymentMethodBreakdown({
    required this.method,
    required this.transactionCount,
    required this.totalAmount,
    required this.sharePercent,
    required this.estimatedProcessingFees,
  });
}
