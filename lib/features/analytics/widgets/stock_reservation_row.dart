import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One active online-checkout hold (Issue #445): item, quantity locked, and
/// actions to complete or cancel the checkout.
class StockReservationRow extends StatelessWidget {
  final StockReservationEntity reservation;
  final VoidCallback onConfirm;
  final VoidCallback onRelease;

  const StockReservationRow({
    super.key,
    required this.reservation,
    required this.onConfirm,
    required this.onRelease,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text('${reservation.itemName}  × ${reservation.quantityReserved}',
                overflow: TextOverflow.ellipsis),
          ),
          ShadButton.outline(onPressed: onRelease, child: const Text('Release')),
          const SizedBox(width: 8),
          ShadButton(onPressed: onConfirm, child: const Text('Confirm')),
        ],
      ),
    );
  }
}
