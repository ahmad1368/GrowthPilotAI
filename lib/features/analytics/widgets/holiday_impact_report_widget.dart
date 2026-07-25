import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_holiday_sales_impact.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/holiday_impact_row.dart';

/// Registers the Public Holiday Sales Impact widget (Issue #388) as a
/// pluggable report widget under id `HOLIDAY_IMPACT` (#111): fixed-date
/// Canadian statutory holidays ranked by revenue lift vs. an ordinary-day
/// baseline. Only holidays with matching transaction history are shown.
class HolidayImpactReportWidget extends BaseReportWidget {
  const HolidayImpactReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    final items = ComputeHolidaySalesImpact.call(
        data['transactions'] as List<TransactionEntity>);
    if (items.isEmpty) {
      return const Text('Not enough transaction history around statutory holidays yet.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items) HolidayImpactRow(item: item),
      ],
    );
  }
}
