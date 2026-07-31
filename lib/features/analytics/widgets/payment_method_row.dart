import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/payment_method_breakdown.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One payment channel's volume share and estimated fee drag (Issue #391).
class PaymentMethodRow extends StatelessWidget {
  final PaymentMethodBreakdown breakdown;

  const PaymentMethodRow({super.key, required this.breakdown});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(breakdown.method.name)),
          Text('${breakdown.sharePercent.toStringAsFixed(0)}%',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(breakdown.totalAmount)),
          const SizedBox(width: 8),
          Text(
            breakdown.estimatedProcessingFees > 0
                ? '-${CurrencyFormat.cad(breakdown.estimatedProcessingFees)} fees'
                : 'No fees',
            style: TextStyle(
                fontSize: 11,
                color: breakdown.estimatedProcessingFees > 0
                    ? scheme.error
                    : scheme.primary),
          ),
        ],
      ),
    );
  }
}
