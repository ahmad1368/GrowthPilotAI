import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_channel_select.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_item_select.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_type_select.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_quantity_input.dart';

/// Item + direction + channel + quantity fields for a new stock movement
/// (Issue #439, channel added in #445).
class StockMovementFields extends StatelessWidget {
  final List<InventoryItemEntity> items;
  final InventoryItemEntity? selectedItem;
  final ValueChanged<InventoryItemEntity?> onItemChanged;
  final StockMovementType type;
  final ValueChanged<StockMovementType?> onTypeChanged;
  final SalesChannel channel;
  final ValueChanged<SalesChannel?> onChannelChanged;
  final TextEditingController quantityController;

  const StockMovementFields({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onItemChanged,
    required this.type,
    required this.onTypeChanged,
    required this.channel,
    required this.onChannelChanged,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StockMovementItemSelect(
            items: items, selectedItem: selectedItem, onChanged: onItemChanged),
        const SizedBox(height: 8),
        StockMovementTypeSelect(type: type, onChanged: onTypeChanged),
        const SizedBox(height: 8),
        StockMovementChannelSelect(channel: channel, onChanged: onChannelChanged),
        const SizedBox(height: 8),
        StockQuantityInput(controller: quantityController),
      ],
    );
  }
}
