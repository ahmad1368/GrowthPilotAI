import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/item_valuation.dart';
import 'package:growth_pilot_ai/core/models/valuation_method.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_export_button.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_method_select.dart';

/// Method picker, export action, and running total (Issue #446).
class InventoryValuationHeader extends StatelessWidget {
  final GlobalKey boundaryKey;
  final ValuationMethod method;
  final ValueChanged<ValuationMethod?> onMethodChanged;
  final List<ItemValuation> valuations;

  const InventoryValuationHeader({
    super.key,
    required this.boundaryKey,
    required this.method,
    required this.onMethodChanged,
    required this.valuations,
  });

  @override
  Widget build(BuildContext context) {
    final total = valuations.fold<double>(0, (sum, v) => sum + v.totalValue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Expanded(child: InventoryValuationMethodSelect(method: method, onChanged: onMethodChanged)),
          InventoryValuationExportButton(
              boundaryKey: boundaryKey, valuations: valuations, title: 'Inventory Valuation'),
        ]),
        const SizedBox(height: 8),
        Text('Total value: ${CurrencyFormat.cad(total)}',
            style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
