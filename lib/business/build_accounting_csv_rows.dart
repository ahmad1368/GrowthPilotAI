import 'package:growth_pilot_ai/core/models/merchant_accounting_summary.dart';

/// Maps computed accounting summaries to the row shape [ExportStrategy]
/// consumes (Issue #427, acceptance criterion 1).
class BuildAccountingCsvRows {
  static List<Map<String, dynamic>> call(List<MerchantAccountingSummary> summaries) {
    return [
      for (final s in summaries)
        {
          'merchantName': s.merchantName,
          'totalFees': s.totalFees,
          'totalWaived': s.totalWaived,
          'totalPayouts': s.totalPayouts,
          'taxDeduction': s.taxDeduction,
          'netEarnings': s.netEarnings,
        },
    ];
  }
}
