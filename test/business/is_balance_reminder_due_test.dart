import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_balance_reminder_due.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';

SeasonalCatalogItemEntity _catalogItem() {
  return SeasonalCatalogItemEntity(
    id: 1,
    supplierName: 'Supplier',
    productName: 'Item',
    productDescription: '',
    unitPrice: 10,
    depositPercent: 0.2,
    deliveryWindowStart: DateTime(2026, 12, 1),
    listedAt: DateTime(2026, 1, 1),
  );
}

PreOrderReservationEntity _reservation({required PreOrderReservationStatus status}) {
  return PreOrderReservationEntity(
    id: 1,
    catalogItemId: 1,
    merchantName: 'Merchant',
    quantity: 5,
    depositAmount: 10,
    dbStatus: status.index,
    reservedAt: DateTime(2026, 1, 2),
  );
}

void main() {
  test('not due more than the reminder window before delivery', () {
    final result = IsBalanceReminderDue.call(
        _catalogItem(), _reservation(status: PreOrderReservationStatus.depositPaid), DateTime(2026, 10, 1));
    expect(result, false);
  });

  test('due within the reminder window before delivery', () {
    final result = IsBalanceReminderDue.call(
        _catalogItem(), _reservation(status: PreOrderReservationStatus.depositPaid), DateTime(2026, 11, 25));
    expect(result, true);
  });

  test('never due once the balance is already paid', () {
    final result = IsBalanceReminderDue.call(
        _catalogItem(), _reservation(status: PreOrderReservationStatus.balancePaid), DateTime(2026, 11, 25));
    expect(result, false);
  });
}
