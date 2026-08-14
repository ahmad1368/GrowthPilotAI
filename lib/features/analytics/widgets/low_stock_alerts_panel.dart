import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/scan_low_stock_alerts.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Lightweight UI wrapper for low-stock alerts (Issue #440). Keeps the view
/// presentational while the business use case does the evaluation.
class LowStockAlertsPanel extends StatefulWidget {
  final List<InventoryItemEntity> items;

  const LowStockAlertsPanel({super.key, required this.items});

  @override
  State<LowStockAlertsPanel> createState() => _LowStockAlertsPanelState();
}

class _LowStockAlertsPanelState extends State<LowStockAlertsPanel> {
  late Future<OmniResponse<List<dynamic>>> _alertsFuture;

  @override
  void initState() {
    super.initState();
    _alertsFuture = ScanLowStockAlerts.call(widget.items, DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return FutureBuilder<OmniResponse<List<dynamic>>>(
      future: _alertsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final alerts = snapshot.data!.data ?? const [];
        if (alerts.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Low stock alerts',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: scheme.onSurface)),
              const SizedBox(height: 6),
              ...alerts.map((alert) =>
                  Text(alert.title, style: TextStyle(color: scheme.onSurface))),
            ],
          ),
        );
      },
    );
  }
}
