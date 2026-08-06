import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_fulfillment_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_reservation_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_view.dart';

/// Owns catalog/reservation state for the seasonal pre-ordering
/// engine (Issue #417).
class SeasonalCatalogBody extends StatefulWidget {
  final List<SeasonalCatalogItemEntity> catalogItems;
  const SeasonalCatalogBody({super.key, required this.catalogItems});
  @override
  State<SeasonalCatalogBody> createState() => _SeasonalCatalogBodyState();
}

class _SeasonalCatalogBodyState extends State<SeasonalCatalogBody> {
  final _repos = PreOrderRepos();
  late final _catalogActions = SeasonalCatalogActions(_repos);
  late final _reservationActions = PreOrderReservationActions(_repos);
  late final _fulfillmentActions = PreOrderFulfillmentActions(_repos);
  late List<SeasonalCatalogItemEntity> _catalogItems = widget.catalogItems;
  late List<PreOrderReservationEntity> _reservations = _repos.reservations.getAll();

  void _mutate(void Function() action) {
    action();
    setState(() => _reservations = _repos.reservations.getAll());
  }

  Future<void> _create() async {
    final item = await showSeasonalCatalogDialog(context);
    if (item == null) return;
    setState(() => _catalogItems = [..._catalogItems, _catalogActions.create(item)]);
  }

  void _reserve(SeasonalCatalogItemEntity item, String name, int qty) =>
      _mutate(() => _reservationActions.reserve(item, name, qty));

  void _settleBalance(PreOrderReservationEntity r) =>
      _mutate(() => _reservationActions.settleBalance(r));

  void _confirmFulfillment(PreOrderReservationEntity r) =>
      _mutate(() => _fulfillmentActions.confirmFulfillment(r));

  void _refund(PreOrderReservationEntity r) => _mutate(() => _fulfillmentActions.refundDeposit(r));

  @override
  Widget build(BuildContext context) {
    return SeasonalCatalogView(
      catalogItems: _catalogItems,
      reservations: _reservations,
      onCreate: _create,
      onReserve: _reserve,
      onSettleBalance: _settleBalance,
      onConfirmFulfillment: _confirmFulfillment,
      onRefund: _refund,
    );
  }
}
