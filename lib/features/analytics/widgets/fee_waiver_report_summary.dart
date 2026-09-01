import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_promotional_waiver_report.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';

/// Promotional acquisition-spend readout for financial reporting
/// (Issue #420, acceptance criterion 5).
class FeeWaiverReportSummary extends StatelessWidget {
  final List<FeeWaiverRecordEntity> records;

  const FeeWaiverReportSummary({super.key, required this.records});

  @override
  Widget build(BuildContext context) {
    final report = ComputePromotionalWaiverReport.call(records);
    return Text(
      '${report.waiverCount} promotional waiver(s) — '
      '\$${report.totalWaivedAmount.toStringAsFixed(2)} in acquisition spend',
      style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
    );
  }
}
