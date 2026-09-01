import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_payment_method_breakdown.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/payment_method_view.dart';

/// Registers the Customer Payment Pattern Analyzer (Issue #391) as a
/// pluggable report widget under id `PAYMENT_METHOD_ANALYZER` (#111).
class PaymentMethodReportWidget extends BaseReportWidget {
  const PaymentMethodReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final breakdowns = ComputePaymentMethodBreakdown.call(
        data['transactions'] as List<TransactionEntity>);
    return PaymentMethodView(breakdowns: breakdowns);
  }
}
