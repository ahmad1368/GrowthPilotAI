import 'package:growth_pilot_ai/business/build_inventory_valuation_csv_rows.dart';
import 'package:growth_pilot_ai/business/share_csv_bytes.dart';
import 'package:growth_pilot_ai/business/slugify_title.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/interfaces/export_strategy.dart';
import 'package:growth_pilot_ai/core/models/export_options.dart';
import 'package:growth_pilot_ai/core/models/item_valuation.dart';

/// Serializes the valuation summary to CSV and shares it (Issue #446).
class ExportInventoryValuationCsv {
  static Future<void> call(List<ItemValuation> valuations, String title) async {
    final rows = BuildInventoryValuationCsvRows.call(valuations);
    const options = ExportOptions(fields: ['item', 'quantityOnHand', 'totalValue']);
    final csv = DependencyInjection.get<ExportStrategy>().generate(rows, options);
    await ShareCsvBytes.call(csv, '${SlugifyTitle.call(title)}.csv');
  }
}
