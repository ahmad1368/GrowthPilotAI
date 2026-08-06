import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/aggregate_pre_order_demand.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';

PreOrderReservationEntity _reservation(int id, int catalogItemId, int quantity,
    PreOrderReservationStatus status) {
  return PreOrderReservationEntity(
    id: id,
    catalogItemId: catalogItemId,
    merchantName: 'Merchant $id',
    quantity: quantity,
    depositAmount: 10,
    dbStatus: status.index,
    reservedAt: DateTime(2026, 1, 2),
  );
}

void main() {
  test('sums quantity across reservations for the catalog item, excluding refunds', () {
    final reservations = [
      _reservation(1, 1, 20, PreOrderReservationStatus.depositPaid),
      _reservation(2, 1, 30, PreOrderReservationStatus.balancePaid),
      _reservation(3, 1, 15, PreOrderReservationStatus.refunded),
      _reservation(4, 2, 999, PreOrderReservationStatus.depositPaid),
    ];

    final demand = AggregatePreOrderDemand.call(1, reservations);

    expect(demand.totalQuantity, 50);
    expect(demand.reservationCount, 2);
  });
}
