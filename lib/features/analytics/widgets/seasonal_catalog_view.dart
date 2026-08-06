import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_seasonal_catalog_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_catalog_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a new-catalog-line button, every catalog card, and a
/// summary narrative (Issue #417). Purely presentational.
class SeasonalCatalogView extends StatelessWidget {
  final List<SeasonalCatalogItemEntity> catalogItems;
  final List<PreOrderReservationEntity> reservations;
  final VoidCallback onCreate;
  final void Function(SeasonalCatalogItemEntity, String, int) onReserve;
  final void Function(PreOrderReservationEntity) onSettleBalance;
  final void Function(PreOrderReservationEntity) onConfirmFulfillment;
  final void Function(PreOrderReservationEntity) onRefund;

  const SeasonalCatalogView({
    super.key,
    required this.catalogItems,
    required this.reservations,
    required this.onCreate,
    required this.onReserve,
    required this.onSettleBalance,
    required this.onConfirmFulfillment,
    required this.onRefund,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          ShadButton.outline(
              onPressed: onCreate, child: Text('+ List Seasonal Line', style: TextStyle(color: fg))),
        ]),
        for (final item in catalogItems)
          SeasonalCatalogRow(
            catalogItem: item,
            reservations: reservations.where((r) => r.catalogItemId == item.id).toList(),
            onReserve: (name, qty) => onReserve(item, name, qty),
            onSettleBalance: onSettleBalance,
            onConfirmFulfillment: onConfirmFulfillment,
            onRefund: onRefund,
          ),
        const SizedBox(height: 8),
        Text(BuildSeasonalCatalogNarrative.call(catalogItems)),
      ],
    );
  }
}
