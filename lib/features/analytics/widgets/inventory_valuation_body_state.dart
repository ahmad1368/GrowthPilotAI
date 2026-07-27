import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_valuation_trend.dart';
import 'package:growth_pilot_ai/business/compute_item_valuations.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/models/valuation_method.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_cost_layer_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_body.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_view.dart';

/// State for [InventoryValuationBody] (Issue #446): records cost layers and
/// recomputes the selected method's valuations/trend.
class InventoryValuationBodyState extends State<InventoryValuationBody> {
  final _boundaryKey = GlobalKey();
  late List<InventoryCostLayerEntity> _layers = widget.initialLayers;
  ValuationMethod _method = ValuationMethod.fifo;

  Future<void> _recordLayer() async {
    final draft = await showInventoryCostLayerDialog(context, widget.items);
    if (draft == null) return;

    final layer = InventoryCostLayerEntity(
      itemId: draft.item.id,
      itemName: draft.item.name,
      quantity: draft.quantity,
      unitCost: draft.unitCost,
      receivedAt: DateTime.now(),
    );
    Get.find<ObjectBox>().store.box<InventoryCostLayerEntity>().put(layer);
    setState(() => _layers = [..._layers, layer]);
  }

  @override
  Widget build(BuildContext context) {
    return InventoryValuationView(
      boundaryKey: _boundaryKey,
      method: _method,
      onMethodChanged: (v) => setState(() => _method = v ?? _method),
      valuations: ComputeItemValuations.call(widget.items, _layers, _method),
      trend: BuildValuationTrend.call(_layers),
      onRecordLayer: _recordLayer,
    );
  }
}
