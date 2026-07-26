import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_item_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inventory_stock_take_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_view.dart';

/// Owns the stock-take record list (Issue #441), refreshing it locally
/// after each quick-add insert and reconciling the item's quantity on hand
/// to the physical count. Rendering itself is [StockTakeView]'s job.
class StockTakeBody extends StatefulWidget {
  final List<InventoryStockTakeEntity> initialRecords;
  final List<InventoryItemEntity> items;

  const StockTakeBody({super.key, required this.initialRecords, required this.items});

  @override
  State<StockTakeBody> createState() => _StockTakeBodyState();
}

class _StockTakeBodyState extends State<StockTakeBody> {
  late List<InventoryStockTakeEntity> _records = widget.initialRecords;

  Future<void> _addRecord() async {
    final draft = await showStockTakeDialog(context, widget.items);
    if (draft == null) return;
    final store = Get.find<ObjectBox>().store;
    InventoryStockTakeRepository(store.box<InventoryStockTakeEntity>()).insert(draft.record);

    draft.item.quantityOnHand = draft.record.physicalQuantity;
    InventoryItemRepository(store.box<InventoryItemEntity>()).insert(draft.item);

    setState(() => _records = [..._records, draft.record]);
  }

  @override
  Widget build(BuildContext context) =>
      StockTakeView(records: _records, onAddRecord: _addRecord);
}
