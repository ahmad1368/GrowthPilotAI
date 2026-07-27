import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/apply_stock_movement.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_view.dart';

/// Owns the stock-movement log (Issue #439): applies each recorded sale or
/// return through [ApplyStockMovement]'s atomic transaction and refreshes
/// the list locally. Rendering itself is [StockMovementView]'s job.
class StockMovementBody extends StatefulWidget {
  final List<StockMovementEntity> initialMovements;
  final List<InventoryItemEntity> items;

  const StockMovementBody({super.key, required this.initialMovements, required this.items});

  @override
  State<StockMovementBody> createState() => _StockMovementBodyState();
}

class _StockMovementBodyState extends State<StockMovementBody> {
  late List<StockMovementEntity> _movements = widget.initialMovements;

  Future<void> _recordMovement() async {
    final draft = await showStockMovementDialog(context, widget.items);
    if (draft == null) return;

    final store = Get.find<ObjectBox>().store;
    final result = await ApplyStockMovement.call(
        store, draft.item.id, draft.quantity, draft.type,
        channel: draft.channel);

    if (!result.success) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.message ?? 'Movement failed.')));
      return;
    }
    setState(() => _movements = [..._movements, result.data!]);
  }

  @override
  Widget build(BuildContext context) =>
      StockMovementView(movements: _movements, onRecordMovement: _recordMovement);
}
