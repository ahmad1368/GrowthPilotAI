import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/inventory_valuation_point.dart';
import 'package:growth_pilot_ai/core/models/item_valuation.dart';
import 'package:growth_pilot_ai/core/models/valuation_method.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_chart.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_header.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the header, trend chart, rows, and record action (Issue #446).
class InventoryValuationView extends StatelessWidget {
  final GlobalKey boundaryKey;
  final ValuationMethod method;
  final ValueChanged<ValuationMethod?> onMethodChanged;
  final List<ItemValuation> valuations;
  final List<InventoryValuationPoint> trend;
  final VoidCallback onRecordLayer;

  const InventoryValuationView({
    super.key,
    required this.boundaryKey,
    required this.method,
    required this.onMethodChanged,
    required this.valuations,
    required this.trend,
    required this.onRecordLayer,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: boundaryKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InventoryValuationHeader(
              boundaryKey: boundaryKey, method: method, onMethodChanged: onMethodChanged, valuations: valuations),
          const SizedBox(height: 8),
          InventoryValuationChart(points: trend),
          const SizedBox(height: 8),
          if (valuations.isEmpty)
            const Text('No inventory items yet.')
          else
            for (final v in valuations) InventoryValuationRow(valuation: v),
          ShadButton.outline(onPressed: onRecordLayer, child: const Text('+ Record Cost Layer')),
        ],
      ),
    );
  }
}
