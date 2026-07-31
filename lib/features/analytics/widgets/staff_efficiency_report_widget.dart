import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/staff_shift_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/staff_efficiency_body.dart';

/// Registers the Staff Work Efficiency Analysis Engine (Issue #379) as a
/// pluggable report widget under id `STAFF_WORK_EFFICIENCY` (#111).
class StaffEfficiencyReportWidget extends BaseReportWidget {
  const StaffEfficiencyReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return StaffEfficiencyBody(
      initialShifts: data['shifts'] as List<StaffShiftEntity>,
      transactions: data['transactions'] as List<TransactionEntity>,
    );
  }
}
