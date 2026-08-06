import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/is_balance_reminder_due.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One merchant's reservation line with status-specific actions
/// (Issue #417, acceptance criteria 2-3 and 5) — split out of
/// [SeasonalCatalogRowActions] to stay under the file line cap.
class PreOrderReservationRow extends StatelessWidget {
  final SeasonalCatalogItemEntity catalogItem;
  final PreOrderReservationEntity reservation;
  final VoidCallback onSettleBalance;
  final VoidCallback onConfirmFulfillment;
  final VoidCallback onRefund;

  const PreOrderReservationRow({
    super.key,
    required this.catalogItem,
    required this.reservation,
    required this.onSettleBalance,
    required this.onConfirmFulfillment,
    required this.onRefund,
  });

  @override
  Widget build(BuildContext context) {
    final reminderDue = IsBalanceReminderDue.call(catalogItem, reservation, DateTime.now());
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 4),
      child: Row(children: [
        Expanded(
          child: Text(
              '${reservation.merchantName}: ${reservation.quantity} unit(s), '
              'deposit \$${reservation.depositAmount.toStringAsFixed(2)} — ${reservation.status.name}'
              '${reminderDue ? ' (balance due soon)' : ''}',
              style: const TextStyle(fontSize: 12)),
        ),
        if (reservation.status == PreOrderReservationStatus.depositPaid)
          ShadButton.ghost(onPressed: onSettleBalance, child: const Text('Pay Balance')),
        if (reservation.status == PreOrderReservationStatus.balancePaid)
          ShadButton.ghost(onPressed: onConfirmFulfillment, child: const Text('Confirm Delivery')),
        if (reservation.status == PreOrderReservationStatus.depositPaid ||
            reservation.status == PreOrderReservationStatus.balancePaid)
          ShadButton.ghost(onPressed: onRefund, child: const Text('Cancel & Refund')),
      ]),
    );
  }
}
