import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/aggregate_pre_order_demand.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';

/// Regional demand-aggregation readout for the supplier forecasting
/// dashboard (Issue #417, acceptance criterion 4).
class PreOrderDemandSummary extends StatelessWidget {
  final int catalogItemId;
  final List<PreOrderReservationEntity> reservations;

  const PreOrderDemandSummary({super.key, required this.catalogItemId, required this.reservations});

  @override
  Widget build(BuildContext context) {
    final demand = AggregatePreOrderDemand.call(catalogItemId, reservations);
    return Text(
      'Regional demand: ${demand.totalQuantity} unit(s) across ${demand.reservationCount} reservation(s)',
      style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
    );
  }
}
