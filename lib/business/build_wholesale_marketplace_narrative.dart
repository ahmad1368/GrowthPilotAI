import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/business/compute_capital_recovered.dart';

/// One-sentence read summarizing wholesale liquidation activity
/// (Issue #411, acceptance criterion 5), mirroring
/// [BuildAdRequestNarrative]'s summary pattern.
class BuildWholesaleMarketplaceNarrative {
  static String call(List<WholesaleOrderEntity> orders) {
    if (orders.isEmpty) {
      return 'No wholesale clearance sales yet.';
    }
    final recovered = ComputeCapitalRecovered.call(orders);
    return '${orders.length} wholesale order(s) completed, recovering '
        '\$${recovered.toStringAsFixed(2)} in tied-up capital.';
  }
}
