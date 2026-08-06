import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';

/// Whether a deposit-only reservation is within the balance-due
/// reminder window ahead of the seasonal delivery date (Issue #417,
/// acceptance criterion 3) — this app has no push-notification/
/// background-scheduler backend, so the "automated" reminder is a
/// derived read surfaced as a banner, the same simplification
/// [IsGroupPurchaseExpired] uses for campaign deadlines.
class IsBalanceReminderDue {
  static bool call(SeasonalCatalogItemEntity catalogItem, PreOrderReservationEntity reservation,
      DateTime now,
      {int reminderWindowDays = 14}) {
    if (reservation.status != PreOrderReservationStatus.depositPaid) return false;
    final reminderStart =
        catalogItem.deliveryWindowStart.subtract(Duration(days: reminderWindowDays));
    return now.isAfter(reminderStart) && now.isBefore(catalogItem.deliveryWindowStart);
  }
}
