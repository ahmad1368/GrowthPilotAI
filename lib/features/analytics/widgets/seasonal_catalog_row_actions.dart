import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_demand_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_reservation_input.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_reservation_row.dart';

/// Reservation input, list, and demand summary for one catalog line
/// (Issue #417) — split out of [SeasonalCatalogRow] to stay under the
/// file line cap.
class SeasonalCatalogRowActions extends StatelessWidget {
  final SeasonalCatalogItemEntity catalogItem;
  final List<PreOrderReservationEntity> reservations;
  final void Function(String merchantName, int quantity) onReserve;
  final void Function(PreOrderReservationEntity) onSettleBalance;
  final void Function(PreOrderReservationEntity) onConfirmFulfillment;
  final void Function(PreOrderReservationEntity) onRefund;

  const SeasonalCatalogRowActions({
    super.key,
    required this.catalogItem,
    required this.reservations,
    required this.onReserve,
    required this.onSettleBalance,
    required this.onConfirmFulfillment,
    required this.onRefund,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      PreOrderReservationInput(onSubmit: onReserve),
      for (final reservation in reservations)
        PreOrderReservationRow(
          catalogItem: catalogItem,
          reservation: reservation,
          onSettleBalance: () => onSettleBalance(reservation),
          onConfirmFulfillment: () => onConfirmFulfillment(reservation),
          onRefund: () => onRefund(reservation),
        ),
      const SizedBox(height: 4),
      PreOrderDemandSummary(catalogItemId: catalogItem.id, reservations: reservations),
    ]);
  }
}
