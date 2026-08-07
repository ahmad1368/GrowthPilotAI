import 'package:growth_pilot_ai/business/build_accounting_csv_rows.dart';
import 'package:growth_pilot_ai/business/share_csv_bytes.dart';
import 'package:growth_pilot_ai/business/slugify_title.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/interfaces/export_strategy.dart';
import 'package:growth_pilot_ai/core/models/export_options.dart';
import 'package:growth_pilot_ai/core/models/merchant_accounting_summary.dart';

/// Serializes the accounting summary to CSV and shares it (Issue
/// #427, acceptance criterion 1), mirroring
/// [ExportInventoryValuationCsv] (#446).
class ExportAccountingReportCsv {
  static Future<void> call(List<MerchantAccountingSummary> summaries, String title) async {
    final rows = BuildAccountingCsvRows.call(summaries);
    const options = ExportOptions(fields: [
      'merchantName',
      'totalFees',
      'totalWaived',
      'totalPayouts',
      'taxDeduction',
      'netEarnings',
    ]);
    final csv = DependencyInjection.get<ExportStrategy>().generate(rows, options);
    await ShareCsvBytes.call(csv, '${SlugifyTitle.call(title)}.csv');
  }
}
