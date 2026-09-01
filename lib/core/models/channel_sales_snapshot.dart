import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

/// Sales volume and estimated value for one channel (Issue #384) —
/// [estimatedRevenue] uses each item's [unitCost] as a value stand-in,
/// since stock movements carry no sale price of their own.
@immutable
class ChannelSalesSnapshot {
  final SalesChannel channel;
  final int unitsSold;
  final double estimatedRevenue;

  const ChannelSalesSnapshot({
    required this.channel,
    required this.unitsSold,
    required this.estimatedRevenue,
  });
}
