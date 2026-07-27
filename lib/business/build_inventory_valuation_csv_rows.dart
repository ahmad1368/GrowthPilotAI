import 'package:growth_pilot_ai/core/models/item_valuation.dart';

/// Maps computed item valuations to the row shape [ExportStrategy]
/// consumes (Issue #446).
class BuildInventoryValuationCsvRows {
  static List<Map<String, dynamic>> call(List<ItemValuation> valuations) {
    return [
      for (final v in valuations)
        {
          'item': v.item.name,
          'quantityOnHand': v.item.quantityOnHand,
          'totalValue': v.totalValue,
        },
    ];
  }
}
