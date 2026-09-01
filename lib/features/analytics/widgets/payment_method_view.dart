import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_payment_fee_narrative.dart';
import 'package:growth_pilot_ai/core/models/payment_method_breakdown.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/payment_method_row.dart';

/// Renders per-channel payment rows and a processing-fee narrative
/// (Issue #391).
class PaymentMethodView extends StatelessWidget {
  final List<PaymentMethodBreakdown> breakdowns;

  const PaymentMethodView({super.key, required this.breakdowns});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (breakdowns.isEmpty)
          const Text('No customer payments recorded yet.')
        else
          for (final breakdown in breakdowns) PaymentMethodRow(breakdown: breakdown),
        const SizedBox(height: 8),
        Text(BuildPaymentFeeNarrative.call(breakdowns)),
      ],
    );
  }
}
