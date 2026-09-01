import 'package:growth_pilot_ai/core/models/price_volatility_alert.dart';

/// One-sentence read naming the most severe price swing and how many
/// breached the configured threshold (Issue #340).
class BuildPriceVolatilityNarrative {
  static String call(List<PriceVolatilityAlert> results) {
    if (results.isEmpty) {
      return 'No price observations logged yet — log at least two per product to track swings.';
    }
    final breached = results.where((r) => r.isBreached).length;
    final top = results.first;
    final direction = top.changePercent >= 0 ? 'up' : 'down';
    return '$breached of ${results.length} product(s) breached the threshold — '
        '"${top.productName}" moved $direction ${top.changePercent.abs().toStringAsFixed(1)}%.';
  }
}
