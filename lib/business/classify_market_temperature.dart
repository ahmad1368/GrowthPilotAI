import 'package:growth_pilot_ai/core/enum/market_temperature.dart';

/// Buckets peer-group volume into 3 tiers (Issue #103's own snippet only
/// used a binary HOT/COLD split despite its DTO declaring 3 states; this
/// fills in the WARM middle tier).
class ClassifyMarketTemperature {
  static MarketTemperature call(int peerGroupSize) {
    if (peerGroupSize > 50) return MarketTemperature.hot;
    if (peerGroupSize >= 10) return MarketTemperature.warm;
    return MarketTemperature.cold;
  }
}
