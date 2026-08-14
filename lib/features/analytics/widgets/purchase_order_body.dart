import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/generate_purchase_order_draft.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/purchase_order_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_view.dart';

/// Owns the purchase-order list (Issue #443), refreshing it locally after
/// each generated draft is saved or marked sent. Rendering itself is
/// [PurchaseOrderView]'s job.
class PurchaseOrderBody extends StatefulWidget {
  final List<PurchaseOrderEntity> initialOrders;
  final List<InventoryItemEntity> items;

  const PurchaseOrderBody({super.key, required this.initialOrders, required this.items});

  @override
  State<PurchaseOrderBody> createState() => _PurchaseOrderBodyState();
}

class _PurchaseOrderBodyState extends State<PurchaseOrderBody> {
  late List<PurchaseOrderEntity> _orders = widget.initialOrders;

  Future<void> _generateDraft() async {
    final draft = GeneratePurchaseOrderDraft.call(widget.items);
    if (draft == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Nothing to reorder right now.')));
      return;
    }
    final order = await showPurchaseOrderDialog(context, draft);
    if (order == null) return;
    PurchaseOrderRepository(Get.find<ObjectBox>().store.box<PurchaseOrderEntity>())
        .insert(order);
    setState(() => _orders = [..._orders, order]);
  }

  void _markSent(PurchaseOrderEntity order) {
    order.status = PurchaseOrderStatus.sent;
    PurchaseOrderRepository(Get.find<ObjectBox>().store.box<PurchaseOrderEntity>())
        .insert(order);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => PurchaseOrderView(
      orders: _orders, onGenerateDraft: _generateDraft, onMarkSent: _markSent);
}
