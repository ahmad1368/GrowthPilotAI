import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/find_next_wholesale_candidate.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/dead_stock_liquidation_snapshot.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/wholesale_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/wholesale_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/wholesale_view.dart';
/// Owns marketplace listing/cart state (Issue #411).
class WholesaleBody extends StatefulWidget {
  final List<InventoryItemEntity> items;
  final List<StockMovementEntity> movements;
  final List<InventoryCostLayerEntity> layers;
  const WholesaleBody(
      {super.key, required this.items, required this.movements, required this.layers});
  @override
  State<WholesaleBody> createState() => _WholesaleBodyState();
}
class _WholesaleBodyState extends State<WholesaleBody> {
  final _repos = WholesaleRepos();
  late final _actions = WholesaleActions(_repos);
  late List<WholesaleListingEntity> _listings = _repos.listings.getAll();
  final _cart = <int>{};
  final _buyerController = TextEditingController();
  DeadStockLiquidationSnapshot? get _candidate => FindNextWholesaleCandidate.call(
      items: widget.items, movements: widget.movements, layers: widget.layers, listings: _listings);
  void _flagSurplus() {
    final updated = _actions.flagNextSurplus(_candidate, _listings);
    if (updated != null) setState(() => _listings = updated);
  }
  void _toggleCart(int id) => setState(() => _cart.contains(id) ? _cart.remove(id) : _cart.add(id));
  Future<void> _checkout(String buyerName) async {
    final updated = await _actions.checkoutCart(_listings, _cart, buyerName);
    if (updated == null) return;
    setState(() { _listings = updated; _cart.clear(); });
  }
  @override
  Widget build(BuildContext context) {
    return WholesaleView(
      listings: _listings, orders: _repos.orders.getAll(), cart: _cart,
      hasCandidate: _candidate != null, buyerController: _buyerController,
      onFlagSurplus: _flagSurplus, onToggleCart: _toggleCart,
      onCheckout: _cart.isEmpty ? null : () => _checkout(_buyerController.text),
    );
  }
}
