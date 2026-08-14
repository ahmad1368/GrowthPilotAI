import 'package:growth_pilot_ai/business/compute_promotional_waiver_report.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';

/// One-sentence read summarizing the promotional waiver pipeline
/// (Issue #420), mirroring [BuildMicroCreditNarrative]'s summary
/// pattern.
class BuildFeeWaiverNarrative {
  static String call(List<FeeWaiverRecordEntity> records) {
    if (records.isEmpty) {
      return 'No fee-waiver decisions recorded yet.';
    }
    final report = ComputePromotionalWaiverReport.call(records);
    return '${records.length} order(s) evaluated: ${report.waiverCount} waived, '
        '\$${report.totalWaivedAmount.toStringAsFixed(2)} in promotional commission spend.';
  }
}
