import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

/// Total capital recovered through completed wholesale liquidation
/// sales (Issue #411, acceptance criterion 5).
class ComputeCapitalRecovered {
  static double call(List<WholesaleOrderEntity> orders) =>
      orders.fold(0, (sum, o) => sum + o.totalAmount);
}
