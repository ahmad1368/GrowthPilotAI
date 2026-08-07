import 'package:growth_pilot_ai/business/build_cra_compliance_csv_rows.dart';
import 'package:growth_pilot_ai/business/share_csv_bytes.dart';
import 'package:growth_pilot_ai/business/slugify_title.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/interfaces/export_strategy.dart';
import 'package:growth_pilot_ai/core/models/cra_compliance_row.dart';
import 'package:growth_pilot_ai/core/models/export_options.dart';

/// Serializes the CRA compliance log to a standardized CSV export and
/// shares it (Issue #428, acceptance criterion 2), mirroring
/// [ExportAccountingReportCsv] (#427).
class ExportCraComplianceReportCsv {
  static Future<void> call(List<CraComplianceRow> rows, String title) async {
    final csvRows = BuildCraComplianceCsvRows.call(rows);
    const options = ExportOptions(fields: [
      'loggedAt',
      'counterpartyName',
      'amount',
      'currency',
      'exchangeRateAtSettlement',
      'taxCategory',
      'transactionHash',
      'integrityValid',
    ]);
    final csv = DependencyInjection.get<ExportStrategy>().generate(csvRows, options);
    await ShareCsvBytes.call(csv, '${SlugifyTitle.call(title)}.csv');
  }
}
