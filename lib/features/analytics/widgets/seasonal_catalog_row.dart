import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_row_actions.dart';

/// One seasonal catalog line card (Issue #417) — header info and
/// reservation actions from [SeasonalCatalogRowActions].
class SeasonalCatalogRow extends StatelessWidget {
  final SeasonalCatalogItemEntity catalogItem;
  final List<PreOrderReservationEntity> reservations;
  final void Function(String, int) onReserve;
  final void Function(PreOrderReservationEntity) onSettleBalance;
  final void Function(PreOrderReservationEntity) onConfirmFulfillment;
  final void Function(PreOrderReservationEntity) onRefund;

  const SeasonalCatalogRow({
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
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${catalogItem.productName} — ${catalogItem.supplierName}'),
          Text(
              '\$${catalogItem.unitPrice.toStringAsFixed(2)}/unit, '
              '${(catalogItem.depositPercent * 100).toStringAsFixed(0)}% deposit — ${catalogItem.status.name}',
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          SeasonalCatalogRowActions(
            catalogItem: catalogItem,
            reservations: reservations,
            onReserve: onReserve,
            onSettleBalance: onSettleBalance,
            onConfirmFulfillment: onConfirmFulfillment,
            onRefund: onRefund,
          ),
        ],
      ),
    );
  }
}
